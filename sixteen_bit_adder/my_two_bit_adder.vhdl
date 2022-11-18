--------------------------------------------------------------------------------
-- Filename : my_two_bit_adder.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-2022
-- Design Name: my_two_bit_adder
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file we show how to combine two full adders
-- into a two bit adder using a structural architecture approach
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

-- A full adder takes two bits a and b and a carry_in bit as inputs
-- the output has two bits to represent the sum and a carry_out bit
-- two bit adder block diagram
-- 
--          -------                       -------             
-- a(0) -->| full  |---> sum(0)  a(1) -->| full  |---> sum(1)
-- b(0) -->| adder |             b(1) -->| adder |
-- Cin  -->|   1   |---------->----------|   2   |---> Cout
--         |       |  Cout           Cin |       |
--          -------                       -------


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_two_bit_adder IS
    PORT (
        a    : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        b    : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Cin  : IN STD_LOGIC;
        sum  : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        Cout : OUT STD_LOGIC
    );
END ENTITY my_two_bit_adder;


ARCHITECTURE Structural OF my_two_bit_adder IS
    -- we only need one signal to connect the Cout port from the
    -- first adder to the Cin port on the second adder
    -- we can repeat this process as many times as necessary
    -- in order to create an adder of any bussize
    SIGNAL C_0 : STD_LOGIC := '0';
BEGIN
    -- the output signal c_0 from the first adder is used as the input signal Cin of the second adder
    full_adder_1 : ENTITY work.my_full_adder(Structural) PORT MAP (a => a(0), b => b(0), Cin => Cin, sum => sum(0), Cout => C_0);
    full_adder_2 : ENTITY work.my_full_adder(Structural_2) PORT MAP (a => a(1), b => b(1), Cin => C_0, sum => sum(1), Cout => Cout);
END Structural;
