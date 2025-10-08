# VHDL CHEATSHEET
The goal of this file is to provide quick reminders, coding patterns, and best practices you can reach for while designing or reviewing digital hardware design in VHDL.

# Libraries
A VHDL _library_ is a collection of design units (packages, entities, architectures, configurations). Before you can use them in a file you must:

1. **Reference** the physical library (with the `library` clause).    
2. **Import** names from packages inside it (with the `use` clause).

## Must-know standard libraries
- `IEEE.STD_LOGIC_1164`  A go-to for almost every FPGA/ASIC design.
- `IEEE.NUMERIC_STD` Adds signed/unsigned arithmetic. Prefer this over `STD_LOGIC_ARITH`.
- `STD.TEXTIO` Text file I/O for testbenches.
```VHDL
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE STD.TEXTIO.ALL;
```

# Entity
The **entity** is a _black-box interface definition_ for a hardware block. It declares **what goes in and out** (ports). Only one entity declaration is allowed per design.
```VHDL
ENTITY <EntityName> IS
    PORT (
        <clk>   : IN  STD_LOGIC;
        <rst_n> : IN  STD_LOGIC;
        <in_a>  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        <out_y> : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END <EntityName>;

```

## Tips
- Keep entity names descriptive.
- Stick to `std_logic` / `std_logic_vector` types and convert to integers _inside_ the architecture.
- Drive widths via generics so the same entity scales easily.
# Architecture
It describes **how** the entity works—its internal signals, processes, and concurrent statements. one design can have multiple architecture blocks.
```VHDL
ARCHITECTURE <ArchitectureName> OF <EntityName> IS
	-- declarative region
BEGIN
	-- statements part
    -- concurrent statements and/or processes go here
END <ArchitectureName>;
```

## Common architecture styles
- `behavioral`/`rtl`: Synthesizable RTL with `process` blocks, signals, no timing delays.
- `dataflow`: Simple combinational logic using pure concurrent assignments.
- `structural`: Hierarchical designs using component instantiation only.
- `hybrid`: A mix of two or more of the other styles.
- `testbench`: Simulation-only. Can use the full language.

## Tips
- Stick to one clock domain → one main sequential process.
- Use  `variable` free concurrent assignments for combinational processes.
- Signals = hardware wires/regs (update _after_ the process).
- Variables = update immediately, stay _inside_ the process.        
- Handle async/sync reset in the first branch for clear readability.
- Don’t mix types. Stick to `std_logic(_vector)` plus `numeric_std` arithmetic types (`signed`, `unsigned`).
# Signals
Declared in the declarative region of an architecture, a signal represent a wire or register in your hardware model.
```VHDL
SIGNAL <signal_name> : <type> := <initial_value>;
```

# Constants
Constants are read-only value. Use it for magic numbers, timing parameters, array sizes, etc. Constants can be declared almost anywhere a declaration is legal.
```VHDL
CONSTANT <constant_name> : <type> := <literal_value>;
```

# Variables
A **variable** is temporary storage local to the statement block that owns it. It takes a new value **immediately** when you use `:=`. Variables are declared Inside a `process` or Inside subprograms.
```VHDL
PROCESS(<sensitivity_list>)
    VARIABLE <var_name> : <type> := <initial_value>;
BEGIN
    <var_name> := <expression>;
    <signal_out> <= <var_name>;  -- commit value to hardware
END PROCESS;
```

# Generics
Generics are compile-time parameters that let you resize or tweak a block without editing code. Treat generics like constants for widths, depths, feature flags, etc.; omit `generic map` to use the default value.

```VHDL
-- inside entity
GENERIC (
    <GEN_NAME> : <type> := <default_value>
);

-- when instantiating
GENERIC MAP (
    <GEN_NAME> => <default_value>
)
```

# Process blocks
Describes a sequential block inside an architecture that runs whenever a signal in its **sensitivity list** changes. For sequential logic (clocked), the sensitivity list usually contains only the clock (and sometimes reset). For combinational logic, it must include all input signals that affect the logic.
```VHDL
<seq_proc> : PROCESS(<clk>)
BEGIN
    IF rising_edge(<clk>) THEN
        IF <rst_n> = '0' THEN
            -- reset
        ELSE
            -- sequential statements
        END IF;
    END IF;
END PROCESS <seq_proc>;

<comb_proc> : PROCESS(sensitivity_list)  -- Must include all input signals that affect the logic.
BEGIN
    -- default assignments
    -- combinational logic
END PROCESS <comb_proc>;

```

## Tips
- Keep designs readable and synthesizable by using **one clocked process per clock domain**
- Execute the **reset branch first** so its effect is obvious.
- Inside a process, use **variables for intermediate math** and assign the final result to signals
- In combinational processes, **drive every output on every path** to avoid unintended latches.
- Don’t rely on reading a signal you just assigned inside the same clocked process (it won’t reflect the new value until the next edge); compute “next” values first or move that logic to a separate combinational process or concurrent assignment.
# Subprograms
Subprograms package reusable logic that can be called by name, keeping the main architecture clean. They can be declared at different scopes: in a package, within an architecture, or inside a process. Two types of subprograms are Functions and Procedures.
## Functions
A function is a subprogram that returns **one** value, with no side-effects on signals.
```VHDL
-- function
FUNCTION <fn_name>(a, b : IN <type>) RETURN <type> IS
BEGIN
    RETURN <expression>;
END <fn_name>;

-- Calling
y <= <fn_name>(x1, x2);
```
## Procedures
A process is a subprogram that can return **many** results via `out` / `inout` parameters and may update signals.
```VHDL
-- procedure
PROCEDURE <proc_name>(
    a        : IN  <type>;
    result_a : OUT <type>
) IS
BEGIN
    result_a := <expression>;
END <proc_name>;

-- Calling
<proc_name>(data_in, data_out_signal);
```

# Component Instantiation
Drop a child block into an architecture and connect its ports to local signals or external ports.

## Direct
```VHDL
u_<inst> : ENTITY WORK.<ChildEntity>(<architecture_name>)
    GENERIC MAP (
        <GEN_NAME> => <value>       -- omit if none
    )
    PORT MAP (
        <child_port> => <local_sig> 
    );
```

## Indirect (Component Declaration+ Instantiation)
```VHDL
-- declarative region
COMPONENT <ChildEntity>
    GENERIC ( <GEN_NAME>  : <type> := <default> );
    PORT    ( <port_name> : <type> );
END COMPONENT;

-- inside architecture body
u_<inst> : <ChildEntity>
    GENERIC MAP ( <GEN_NAME> => <value> )
    PORT MAP    ( <port_name> => <local_sig> );
```

## Tips
- Keep types/dimensions compatible; convert explicitly if needed.
- Use `open` for an intentionally unconnected **output**: `<out_port> => open`.
- Wrap in a `generate` block for multiple instances.

# Type Casting and Type Conversion
VHDL is a strongly typed language so explicit conversion is required when mixing integers, `std_logic_vector`, and arithmetic types like `signed` and `unsigned`.
This section shows **common, synthesizable conversions** used in real designs.

There's a difference between `casting` a type and `converting` between types
- **Type casting**: Tells the compiler to _reinterpret_ the bits of one type as another type. This is allowed only between types that share the same base representation (e.g. `std_logic_vector` ↔ `unsigned` ↔ `signed`).
- **Type conversion**: Actually changes the representation, usually involving arithmetic or resizing (e.g. `unsigned` ↔ `integer`). Conversion requires functions such as `to_unsigned` or `to_integer` from `numeric_std`.
  
## Common Casting and Conversion Patterns
### std_logic_vector ↔ signed / unsigned
These are type casts (reinterpret bits) not conversions.
```vhdl
SIGNAL slv : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL sig_u : UNSIGNED(7 DOWNTO 0);
SIGNAL sig_s : SIGNED(7 DOWNTO 0);

-- Reinterpret bits
sig_u <= unsigned(slv);
sig_s <= signed(slv);
slv   <= STD_LOGIC_VECTOR(sig_u);
```

### Integer ↔ signed / unsigned
```vhdl
SIGNAL val_i : INTEGER RANGE -128 TO 127;
SIGNAL sig_s : SIGNED(7 DOWNTO 0);
SIGNAL sig_u : UNSIGNED(7 DOWNTO 0);

-- Integer → signed / unsigned
sig_s <= to_signed(val_i, sig_s'length);
sig_u <= to_unsigned(val_i, sig_u'length);

-- signed / unsigned → Integer
val_i <= to_integer(sig_s);
val_i <= to_integer(sig_u);
```

### Integer ↔ std_logic_vector
Use `to_unsigned` / `to_signed` and `to_integer` from `IEEE.NUMERIC_STD`.

```vhdl
SIGNAL slv  : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL num  : INTEGER;

-- Integer → std_logic_vector
slv <= STD_LOGIC_VECTOR(to_unsigned(num, slv'length));

-- std_logic_vector → Integer (treat as unsigned)
num <= to_integer(unsigned(slv));
```
## ⚙️ Simulator Surprises to Watch For
Different VHDL simulators handle **out-of-range conversions** differently.
When you convert integers to `SIGNED` or `UNSIGNED` values that don’t fit in the target bit width, you may see different results, for example:
**Vivado XSim** *Wraps bits silently* (mod 2ⁿ behavior). It does not raies **runtime errors**. However other simulators like Questa or GHDL will raise **runtime error** this behavior is tool specific so exercise caution and make sure to follow good coding practices.

✅ **Best Practices**
- Always constrain integers by using the `RANGE` keyword (`INTEGER RANGE 0 TO 255`, `NATURAL`, etc.) when you know valid limits.
- Use assertions to catch range violations early:
  ```vhdl
  assert (val_i >= 0 and val_i < 256)
    report "val_i out of range for 8-bit conversion"
    severity error;
  ```
- Don’t rely on simulator-specific overflow behavior. What simulates “fine” in one may fail in another simulator or when implemented in real hardware.

# Contributing
Spotted an error, missing pattern, or have a useful tip? Feel free to open an issue or submit a pull request. Contributions are welcome!
