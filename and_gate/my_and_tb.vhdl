----------------------------------------------------------------------------------
-- Filename : my_and_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: and gate test bench
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we show a basic testbench for a logic gate
-- the same approach can be used to test the other gates
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_and_tb IS
END ENTITY;

ARCHITECTURE Behavioral OF my_and_tb IS
    SIGNAL a, b, y : STD_LOGIC;
BEGIN

    -- Using direct entity instantiation
    DUT : ENTITY work.my_and(Behavioral) PORT MAP(a => a, b => b, y => y);

    stimulus : -- this process cycles through all the possible values of the inputs, we can verify our design by looking at the output waveform
    PROCESS
    BEGIN
        a <= '0';
        b <= '0';
        WAIT FOR 4 ns;
        a <= '0';
        b <= '1';
        WAIT FOR 4 ns;
        a <= '1';
        b <= '0';
        WAIT FOR 4 ns;
        a <= '1';
        b <= '1';
        WAIT FOR 4 ns;
        WAIT;
    END PROCESS;
END Behavioral;
