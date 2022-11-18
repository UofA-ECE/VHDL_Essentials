--------------------------------------------------------------------------------
-- Filename : my_half_adder_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-2022
-- Design Name: my_half_adder
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file we create a half adder entity
-- with a simple behavioral and structural architectures
-- approaches and methodologies
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_half_adder_tb IS
END ENTITY;

ARCHITECTURE Behavioral OF my_half_adder_tb IS
    -- Signal declaration with initial value
    SIGNAL a, b, h, l : STD_LOGIC := '0';
BEGIN

    DUT : ENTITY work.my_half_adder(Structural) PORT MAP(a => a, b => b, h => h, l => l);

    stimulus :
    -- cycle through all possible input combinations
    PROCESS
    BEGIN
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
