--------------------------------------------------------------------------------
-- Filename : my_full_adder.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-2022
-- Design Name: my_full_adder
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file we show a basic implementation of a full adder
-- Additional Comments: we explore different approaches to writing the
-- architecture block, this can be used as an example on the differences
-- of Behavioral, Hybrid and Structural approaches
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

-- A full adder takes two bits a and b and a carry_in bit as inputs
-- the output has two bits to represent the sum and a carry_out bit
-- Full adder block diagram
-- 
--          -------
-- a   ----| full  |---- Cout
-- b   ----| adder |---- sum
-- Cin ----|       |
--          -------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY my_full_adder IS
    PORT (
        -- input ports
        a   : IN STD_LOGIC;
        b   : IN STD_LOGIC;
        Cin : IN STD_LOGIC;
        -- output ports
        sum  : OUT STD_LOGIC;
        Cout : OUT STD_LOGIC
    );
END ENTITY my_full_adder;

-- in order to write an rtl architecture we need boolean formulas
-- for every output of our circuit, there are many ways of expressing
-- this logic.
ARCHITECTURE rtl OF my_full_adder IS
    SIGNAL and_1, and_2, xor_1 : STD_LOGIC := '0';
BEGIN
    and_1 <= a AND b;
    xor_1 <= a XOR b;
    and_2 <= xor_1 AND Cin;
    Cout  <= and_1 OR and_2;
    sum   <= xor_1 XOR Cin;
END rtl;

-- if we want a more compact approach we can get rid of all the intermediate
-- signals and write the entire formulas in one line however this approach
-- can get really confusing really quick.
ARCHITECTURE logic OF my_full_adder IS
BEGIN
    Cout <= (a AND b) OR ((a XOR b) AND Cin);
    sum  <= a XOR b XOR Cin;
END logic;

-- we can also describe the behavior of our circuit using different types
-- of signals
ARCHITECTURE Behavioral OF my_full_adder IS
    -- we will define some signals of type integer that will hold the
    -- numerical values of the inputs and outputs
    SIGNAL a_n, b_n, Cin_n : INTEGER RANGE 0 TO 1;
    SIGNAL result_n        : INTEGER RANGE 0 TO 3;
    -- this contains the bit vector representation of our output
    SIGNAL result : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    -- Assign integer values to a_n, b_n and Cin_n
    a_n <= 1 WHEN (a = '1') ELSE
        0;
    b_n <= 1 WHEN (b = '1') ELSE
        0;
    Cin_n <= 1 WHEN (Cin = '1') ELSE
        0;

    -- this line describes the entire behavior of our circuit
    result_n <= a_n + b_n + Cin_n; -- Add the numerical values of the inputs

    -- Change the data type of result_n from integer back to std_logic_vector
    result <= STD_LOGIC_VECTOR(to_unsigned(result_n, result'length));

    -- Assign the proper bits to the output ports
    Cout <= result(1);
    sum  <= result(0);

END Behavioral;

-- We can also write a Structural architecture using our components
-- this time we will build our full adder using two half-adders and one OR gate
ARCHITECTURE Structural OF my_full_adder IS
    SIGNAL sum_0, carry_0, carry_1 : STD_LOGIC := '0';
BEGIN
    half_adder_1 : ENTITY work.my_half_adder(Structural) PORT MAP (a => a, b => b, h => carry_0, l => sum_0);
    half_adder_2 : ENTITY work.my_half_adder(Structural) PORT MAP (a => Cin, b => sum_0, h => carry_1, l => sum);
    or_1         : ENTITY work.my_or(Behavioral) PORT MAP (a => carry_0, b => carry_1, y => Cout);
END Structural;

-- yet another way to write a structural architecture for our adder can be done
--  by using the majority circuit we studied previously and a pair of XOR gates
ARCHITECTURE Structural_2 OF my_full_adder IS
    SIGNAL aux : STD_LOGIC;
BEGIN
    majority_1 : ENTITY work.majority(Structural) PORT MAP (m_input(0) => a, m_input(1) => b, m_input(2) => Cin, majority_bit => Cout);
    xor_1      : ENTITY work.my_xor(Behavioral) PORT MAP (a => a, b => b, y => aux);
    xor_2      : ENTITY work.my_xor(Behavioral) PORT MAP (a => aux, b => Cin, y => sum);
END Structural_2;

-- we can also mix both styles of coding to come up with a Hybrid architecture
-- like in the next two examples
ARCHITECTURE Hybrid OF my_full_adder IS
    SIGNAL sum_0, carry_0, carry_1 : STD_LOGIC := '0';
BEGIN
    half_adder_1 : ENTITY work.my_half_adder(Behavioral) PORT MAP (a => a, b => b, h => carry_0, l => sum_0);
    half_adder_2 : ENTITY work.my_half_adder(Behavioral) PORT MAP (a => Cin, b => sum_0, h => carry_1, l => sum);
    Cout <= carry_0 OR carry_1;
END Hybrid;

ARCHITECTURE Hybrid_2 OF my_full_adder IS
BEGIN
    majority_1 : ENTITY work.majority(Structural) PORT MAP (m_input(0) => a, m_input(1) => b, m_input(2) => Cin, majority_bit => Cout);
    sum <= a XOR b XOR Cin;
END Hybrid_2;
