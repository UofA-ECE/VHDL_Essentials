--------------------------------------------------------------------------------
-- Filename : my_eight_bit_adder.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-2022
-- Design Name: my_eight_bit_adder
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file we show how to combine two 4-bit adders
-- into an 8-bit adder using a structural architecture approach
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_eight_bit_adder IS
    PORT (
        a    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        b    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Cin  : IN STD_LOGIC;
        sum  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Cout : OUT STD_LOGIC
    );
END ENTITY my_eight_bit_adder;
-- we can repeat the same approach as with the two 4-bit adders in order to create an 8-bit adder

ARCHITECTURE Structural OF my_eight_bit_adder IS
    SIGNAL sum_0 : STD_LOGIC := '0';
BEGIN
    four_bit_adder_1 : ENTITY work.my_four_bit_adder(Structural) PORT MAP (a => a(3 DOWNTO 0), b => b(3 DOWNTO 0), Cin => Cin, sum => sum(3 DOWNTO 0), Cout => sum_0);
    four_bit_adder_2 : ENTITY work.my_four_bit_adder(Structural) PORT MAP (a => a(7 DOWNTO 4), b => b(7 DOWNTO 4), Cin => sum_0, sum => sum(7 DOWNTO 4), Cout => Cout);
END Structural;
