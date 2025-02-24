library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stepper_driver is
    port(
        step       : in  std_logic;  -- Step pulse input (used as a clock)
        step_mode  : in  std_logic_vector(1 downto 0);  -- "00": full step, "01": half step, "10": wave drive
        enable     : in  std_logic;
        direction  : in  std_logic;
        coils      : out std_logic_vector(3 downto 0)
    );
end stepper_driver;

architecture Behavioral of stepper_driver is
    -- A 3-bit state counter. (Half–step mode uses all 8 states.)
    signal state : unsigned(2 downto 0) := (others => '0');
    signal coil_state     : std_logic_vector(3 downto 0);
begin
    coils <= coil_state;
    -- State update process: on each rising edge of 'step' (when enable is high)
    process(step)
    variable step_inc : unsigned(2 downto 0);
    begin
    if rising_edge(step) then
        if enable = '1' then
        case step_mode is
            when "00" =>
            if (coil_state = "0010") or (coil_state = "0001") or
                (coil_state = "0100") or (coil_state = "1000") then
                step_inc := to_unsigned(2, 3);
            else
                step_inc := to_unsigned(1, 3);
            end if;
            when "01" =>
            -- Half–step: advance one phase (0..7)
            step_inc := to_unsigned(1, 3);
            when "10" =>
            -- Full step or Wave drive: advance two phases (only even numbers, i.e. 0,2,4,6)
            if (coil_state = "0011") or (coil_state = "0110") or
                (coil_state = "1100") or (coil_state = "1001") then
                step_inc := to_unsigned(2, 3);
            else
                step_inc := to_unsigned(1, 3);
            end if;
            when others =>
            step_inc := to_unsigned(0, 3);
        end case;
        
        if direction = '1' then
            state <= state + step_inc;
        else
            state <= state - step_inc;
        end if;
        end if;
    end if;
    end process;


    -- Combinational process to generate the proper coil outputs
    process(state)
        variable idx : integer;
    begin
        case to_integer(state) is
            when 0 => coil_state <= "1000";
            when 1 => coil_state <= "1100";
            when 2 => coil_state <= "0100";
            when 3 => coil_state <= "0110";
            when 4 => coil_state <= "0010";
            when 5 => coil_state <= "0011";
            when 6 => coil_state <= "0001";
            when 7 => coil_state <= "1001";
            when others => coil_state <= "0000";
        end case;
    end process;

end Behavioral;
