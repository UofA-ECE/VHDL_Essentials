# Finite State Machines (FSMs)
A **Finite State Machine (FSM)** models control logic that moves between a set of defined **states** based on inputs and current state.
In hardware, an FSM is implemented as a combination of sequential and combinational logic.

## Typical FSM Structure
An FSM can be described with two processes:
1. A **combinational process** that computes the next state and the outputs.
2. A **state register process** that updates and stores the current state on every clock edge.
<img width="497" height="568" alt="image" src="https://github.com/user-attachments/assets/2b0b4dac-189e-4f2e-8e7d-aed1efcf9881" />

For a more explicit design you can divide it further into three processes:
1. A **combinational process** that computes the outputs from the current state (and inputs if using a Mealy FSM).
2. A **combinational process** that computes the next state.
3. A **sequential process** that stores the current state on every clock edge.
<img width="1123" height="637" alt="image" src="https://github.com/user-attachments/assets/3e6f57bb-57dd-44c9-b1c9-3ef0ffeb441e" />

## Three process FSM Structure
```vhdl
-- Define state type and signals
TYPE state_type IS (STATE_ONE, STATE_TWO, STATE_THREE);
SIGNAL state, next_state : state_type;

-- Sequential process: state update with asynchronous reset
PROCESS (clock, reset)
BEGIN
	IF reset = '0' THEN
		state <= STATE_ONE; -- async reset
	ELSIF rising_edge(clock) THEN
		state <= next_state; -- update on clock's rising edge
	END IF;
END PROCESS;

-- Combinational process: next state logic
PROCESS (state, start, done) -- sensitive to current state and inputs
BEGIN
	-- default assignments to prevent unintended latches
	next_state <= state;

  CASE state IS
		WHEN STATE_ONE =>
      -- next state logic
		WHEN STATE_TWO =>
      -- next state logic
		WHEN STATE_THREE =>
      -- next state logic
		WHEN OTHERS =>
      -- next state logic
      -- output assignments
	END CASE;
END PROCESS;

-- Combinational process: output logic
-- if using Moore model this process is only sensitive to the current state
-- if using a Mealy model include inputs in ssensitivity list
PROCESS (state, start, done)
BEGIN
  CASE state IS
		WHEN STATE_ONE =>
      -- output assignments
		WHEN STATE_TWO =>
      -- output assignments
		WHEN STATE_THREE =>
      -- output assignments
		WHEN OTHERS =>
      -- output assignments
	END CASE;
END PROCESS;

```

## Two process FSM Structure
```vhdl
-- Define state type and signals
TYPE state_type IS (STATE_ONE, STATE_TWO, STATE_THREE);
SIGNAL state, next_state : state_type;

-- Sequential process: state update
PROCESS (clock, reset)
BEGIN
	IF reset = '0' THEN
		state <= STATE_ONE; -- async reset
	ELSIF rising_edge(clock) THEN
		state <= next_state; -- update on clock's rising edge
	END IF;
END PROCESS;

-- Combinational process: next_state/output logic
-- include inputs in sensitivity list
PROCESS (state, start, done)
BEGIN
	-- default assignments
	next_state <= state;

  CASE state IS
		WHEN STATE_ONE =>
      -- next state logic
      -- output assignments
		WHEN STATE_TWO =>
      -- next state logic
      -- output assignments
		WHEN STATE_THREE =>
      -- next state logic
      -- output assignments
		WHEN OTHERS =>
      -- next state logic
      -- output assignments
	END CASE;
END PROCESS;
```

## Best Practices ✅
- Use enumerated types for states (easier to read and debug).
- Use uppercase for states (IDLE, RUN) and lowercase for signals (next_state, done_i).
- make sure to always set default values for outputs and next_state to avoid latches.
- Handle reset explicitly and return to a known state and default values for signals.
- Keep one clock domain per FSM.

## Common Mistakes ❌
- Forgetting to assign next_state in all branches (unintended latches).
- Mixing sequential and combinational logic in one process.
- Using uninitialized signals (leads to unpredictable startup behavior).
- Driving the same signal in two different processes (multiple driver net).
