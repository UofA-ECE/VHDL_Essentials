----------------------------------------------------------------------------------
-- Filename : majority.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: and_gate
-- Module Name: majority
-- Project Name: VHDL_essentials
-- Description : In this file we make a simple design for a two input and gate
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY and_gate IS
    PORT (
        and_input : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        and_out : OUT STD_LOGIC
    );
END and_gate;


ARCHITECTURE Behavioral OF and_gate IS
BEGIN
    PROCESS (and_input) BEGIN
        CASE(and_input) IS
            WHEN "11" => and_out <= '1';
            WHEN OTHERS => and_out <= '0';
        END CASE;
    END PROCESS;
END Behavioral;
