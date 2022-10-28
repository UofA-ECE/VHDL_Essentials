----------------------------------------------------------------------------------
-- Filename : majority.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: majority
-- Module Name: majority
-- Project Name: VHDL_essentials
-- Description : In this file we go over the process of declaring the architecture
-- of a circuit in different ways using VHDL in order to illustrate different
-- approaches and methodologies
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------


-- Importing the standard IEEE libraries
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


-- Top Module Entity declaration
ENTITY majority IS
    PORT (
        -- 3 bit bus input port
        m_input : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- single bit output
        majority_bit : OUT STD_LOGIC
    );
END majority;


-- The architecture part of a VHDL program describes the internal behavior of the electronic circuit.
-- The architecture describes the underlying functionality of the entity 
-- An architecture is always related to an entity and describes the behavior of said entity
-- An entity can have multiple architectures describing the behavior of the entity


ARCHITECTURE Behavioral OF majority IS
-- declarative part
BEGIN
-- statements part
    PROCESS (m_input)
    BEGIN
    -- we can describe the behavior of our circuit by using a case statement
    -- and following the values of the truth table
        CASE(m_input) IS
            WHEN "000" => majority_bit <= '0';
            WHEN "001" => majority_bit <= '0';
            WHEN "010" => majority_bit <= '0';
            WHEN "011" => majority_bit <= '1';
            WHEN "100" => majority_bit <= '0';
            WHEN "101" => majority_bit <= '1';
            WHEN "110" => majority_bit <= '1';
            WHEN "111" => majority_bit <= '1';
            WHEN OTHERS => majority_bit <= '0';
        END CASE;
    END PROCESS;
END Behavioral;



-- we can clean up our code a little bit by grouping all the states
-- that produce a '0' in the putput into one by using the 'OTHERS'
-- keyword and keeping only the states that produce a '1' in the output
ARCHITECTURE Behavioral1 OF majority IS

BEGIN
    PROCESS (m_input) IS BEGIN
        CASE(m_input) IS
        -- list every case that produces a '1' in the output
            WHEN "011" => majority_bit <= '1';
            WHEN "101" => majority_bit <= '1';
            WHEN "110" => majority_bit <= '1';
            WHEN "111" => majority_bit <= '1';
        -- all other cases will produce an output of '0'
            WHEN OTHERS => majority_bit <= '0';
        END CASE;
    END PROCESS;

END Behavioral1;


-- Another approach is to use an IF statement to simplify our logic
-- let's take a look at one way of doing this
ARCHITECTURE Behavioral2 OF majority IS

BEGIN
    PROCESS (m_input) BEGIN
    -- similar to the case statement we can group all the conditions that produce a '1' in the output
    -- and applying an OR function between all of them
        IF m_input = "011" OR m_input = "101" OR m_input = "110" OR m_input = "111" THEN
            majority_bit <= '1';
        ELSE
            majority_bit <= '0';
        END IF;
    END PROCESS;

END Behavioral2;

-- Using a WITH statement we don't need to create a process
ARCHITECTURE Behavioral3 OF majority IS

BEGIN
    WITH m_input SELECT
        majority_bit <= '1' WHEN "011",
                        '1' WHEN "101",
                        '1' WHEN "110",
                        '1' WHEN "111",
                        '0' WHEN OTHERS;
END Behavioral3;


-- We can also use signals to help us with our logic, in this case
-- we will take the individual inputs and combine them into permutations
-- so they will be easier to handle
ARCHITECTURE Behavioral4 OF majority IS
    -- these signals will represent all possible permutations of any two inputs
    SIGNAL permutation_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL permutation_2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL permutation_3 : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
    -- here we assign the values of the input to the appropriate signals
    -- permutation_1 gets the two most significant bits
    permutation_1 <= m_input(2 DOWNTO 1);
    -- permutation_2 gets the two least significant bits
    permutation_2 <= m_input(1 DOWNTO 0);
    -- permutation_3 gets the Most Significant Bit and the Least Significant Bit
    -- here we need to use the concatenation opeartor & to turn the individual bits
    -- into a two bit vector
    permutation_3 <= m_input(2) & m_input(0);

    PROCESS (m_input) BEGIN
        -- if any of the permutations is equal to "11" the output gets '1'
        IF permutation_3 = "11" OR permutation_2 = "11" OR permutation_3 = "11" THEN
            majority_bit <= '1';
        ELSE
            majority_bit <= '0';
        END IF;
    END PROCESS;
END Behavioral4;


-- Now we will use a structural approach to write our definition
-- for this we need a pictorial representation of the circuit we
-- want to implement and use that in order to describe both
-- the components and the conections between them. This can
-- come in the form of a gate level diagram or a block diagram
ARCHITECTURE Structural OF majority IS
    -- We need to declare all the intermediate signals of our circuit
    SIGNAL and_1_out, and_2_out, and_3_out, or_1_out, or_2_out : STD_LOGIC := '0';

BEGIN
    -- Here we instantiate the components and the connections between them
    -- a purely Structural architecture doesn't contain any equations or logic in it
    -- only component declarations and the mappings between them.
    and1 : ENTITY work.and_gate(Behavioral) PORT MAP (and_input => m_input(2 DOWNTO 1), and_out => and_1_out);
    and2 : ENTITY work.and_gate(Behavioral) PORT MAP (and_input => m_input(1 DOWNTO 0), and_out => and_2_out);
    and3 : ENTITY work.and_gate(Behavioral) PORT MAP (and_input(0) => m_input(0), and_input(1) => m_input(2), and_out => and_3_out);
    or1 : ENTITY work.or_gate(Behavioral) PORT MAP (or_input(0) => and_1_out, or_input(1) => and_2_out, or_out => or_1_out);
    or2 : ENTITY work.or_gate(Behavioral) PORT MAP (or_input(0) => or_1_out, or_input(1) => and_3_out, or_out => majority_bit);

END Structural;
