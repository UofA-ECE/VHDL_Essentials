--------------------------------------------------------------------------------
-- Filename : my_sixteen_bit_adder.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-2022
-- Design Name: my_sixteen_bit_adder
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file we show how to combine two 8-bit adders
-- to create a 16-bit adder using a structural architecture approach
-- and also using a generate statement to demonstrate its use
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_sixteen_bit_adder IS
    PORT (
        a    : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
        b    : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
        Cin  : IN STD_LOGIC;
        sum  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
        Cout : OUT STD_LOGIC
    );
END ENTITY my_sixteen_bit_adder;

ARCHITECTURE Structural OF my_sixteen_bit_adder IS
    SIGNAL sum_0 : STD_LOGIC := '0';
BEGIN
    eight_bit_adder_1 : ENTITY work.my_eight_bit_adder(Structural) PORT MAP (a => a(7 DOWNTO 0), b => b(7 DOWNTO 0), Cin => Cin, sum => sum(7 DOWNTO 0), Cout => sum_0);
    eight_bit_adder_2 : ENTITY work.my_eight_bit_adder(Structural) PORT MAP (a => a(15 DOWNTO 8), b => b(15 DOWNTO 8), Cin => sum_0, sum => sum(15 DOWNTO 8), Cout => Cout);
END Structural;

ARCHITECTURE Structural_2 OF my_sixteen_bit_adder IS
    SIGNAL C_aux : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
BEGIN
    C_aux(0) <= Cin;
    Cout     <= C_aux(16);

    -- here we use a generate statement to instantiate all the
    -- necessary components for our 16 bit adder
    G0 : FOR i IN 0 TO 15 GENERATE
        adder : ENTITY work.my_full_adder(Structural) PORT MAP (a => a(i), b => b(i), Cin => C_aux(i), sum => sum(i), Cout => C_aux(i + 1));
    END GENERATE G0;
END Structural_2;
