----------------------------------------------------------------------------------
-- Filename : majority_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: majority
-- Module Name: majority_tb
-- Project Name: VHDL_essentials
-- Description : This file is a testbench for a 3 bit majority circuit
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY majority_tb IS
END majority_tb;

ARCHITECTURE Behavioral OF majority_tb IS

    SIGNAL m_input : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL majority_bit : STD_LOGIC := '0';

BEGIN

    UUT : ENTITY work.majority(Behavioral) PORT MAP(m_input => m_input, majority_bit => majority_bit);

    -- Stimulus proccess to inject all possible input values
    STIMULUS : PROCESS BEGIN
        FOR i IN 0 TO 7 LOOP
            m_input <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, m_input'length));
            WAIT FOR 10 NS;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;
