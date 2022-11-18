--------------------------------------------------------------------------------
-- Filename : keypad_register_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: shift register tb
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : This file implements a simple testbench
-- for our keypad register
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD;

ENTITY shift_register_tb IS
END;

ARCHITECTURE Behavioral OF shift_register_tb IS
    SIGNAL value  : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL clock  : STD_LOGIC                    := '0';
    SIGNAL digits : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    -- I'm using direct instantiation here as an example
    DUT : ENTITY work.shift_register(Behavioral) PORT MAP (value => value, clock => clock, digits => digits);

    clock_process : PROCESS (clock)
    BEGIN
        clock <= NOT clock AFTER 4 ns;
    END PROCESS;

    stimulus : PROCESS
    BEGIN
        value <= "01111";
        WAIT FOR 10 ns;
        value <= "1XXXX";
        WAIT FOR 2100 ns;
        value <= "1XXXX";
        WAIT FOR 500 ns;
        value <= "01010";
        WAIT FOR 10 ns;
        value <= "00000";
        WAIT FOR 1000 ns;
        WAIT;
    END PROCESS;

END Behavioral;
