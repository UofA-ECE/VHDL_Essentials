--------------------------------------------------------------------------------
-- Filename : my_four_bit_adder.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-2022
-- Design Name: my_four_bit_adder
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file we show how to combine two 2-bit adders
-- into a four bit adder using a structural architecture approach
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_four_bit_adder IS
    PORT (
        a    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        b    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cin  : IN STD_LOGIC;
        sum  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout : OUT STD_LOGIC
    );
END ENTITY my_four_bit_adder;

-- we can repeat the same approach as with the two 2-bit adders in order to create a 4-bit adder
ARCHITECTURE Structural OF my_four_bit_adder IS
    SIGNAL sum_0 : STD_LOGIC := '0';
BEGIN
    two_bit_adder_1 : ENTITY work.my_two_bit_adder(Structural) PORT MAP (a => a(1 DOWNTO 0), b => b(1 DOWNTO 0), Cin => Cin, sum => sum(1 DOWNTO 0), Cout => sum_0);
    two_bit_adder_2 : ENTITY work.my_two_bit_adder(Structural) PORT MAP (a => a(3 DOWNTO 2), b => b(3 DOWNTO 2), Cin => sum_0, sum => sum(3 DOWNTO 2), Cout => Cout);
END Structural;
-- or we can go one level lower instead and use four full adders to build our 4-bit adder
ARCHITECTURE Structural2 OF my_four_bit_adder IS
    SIGNAL sum_0, sum_1, sum_2 : STD_LOGIC := '0';
BEGIN
    full_adder_1 : ENTITY work.my_full_adder(Structural) PORT MAP (a => a(0), b => b(0), Cin => Cin, sum => sum(0), Cout => sum_0);
    full_adder_2 : ENTITY work.my_full_adder(Structural) PORT MAP (a => a(1), b => b(1), Cin => sum_0, sum => sum(1), Cout => sum_1);
    full_adder_3 : ENTITY work.my_full_adder(Structural) PORT MAP (a => a(2), b => b(2), Cin => sum_1, sum => sum(2), Cout => sum_2);
    full_adder_4 : ENTITY work.my_full_adder(Structural) PORT MAP (a => a(3), b => b(3), Cin => sum_2, sum => sum(3), Cout => Cout);
END Structural2;
