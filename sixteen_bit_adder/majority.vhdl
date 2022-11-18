--------------------------------------------------------------------------------
-- Filename : majority.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-2022
-- Design Name: majority
-- Module Name: majority
-- Project Name: VHDL_essentials
-- Description : In this file we go over the process of declaring the architecture
-- of a majority circuit using a structural approach
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : MIT
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY majority IS
    PORT (
        -- 3 bit bus input port
        m_input : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- single bit output
        majority_bit : OUT STD_LOGIC
    );
END majority;
ARCHITECTURE Structural OF majority IS
    -- We need to declare all the intermediate signals of our circuit
    SIGNAL and1, and2, and3, or1 : STD_LOGIC := '0';

BEGIN
    -- Here we instantiate the components and the connections between them
    -- a purely Structural architecture doesn't contain any equations or logic in it
    -- only component declarations and the mappings between them.
    and_1 : ENTITY work.my_and(Behavioral) PORT MAP (a => m_input(2), b => m_input(1), y => and1);
    and_2 : ENTITY work.my_and(Behavioral) PORT MAP (a => m_input(1), b => m_input(0), y => and2);
    and_3 : ENTITY work.my_and(Behavioral) PORT MAP (a => m_input(2), b => m_input(0), y => and3);
    or_1  : ENTITY work.my_or(Behavioral) PORT MAP (a => and1, b => and2, y => or1);
    or_2  : ENTITY work.my_or(Behavioral) PORT MAP (a => or1, b => and3, y => majority_bit);

END Structural;
