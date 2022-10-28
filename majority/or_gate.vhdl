----------------------------------------------------------------------------------
-- Filename : majority.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: or_gate
-- Module Name: majority
-- Project Name: VHDL_essentials
-- Description : In this file go over a simple design for a two input or gate
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY or_gate IS
    PORT (
        or_input : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        or_out : OUT STD_LOGIC
    );
END or_gate;


ARCHITECTURE Behavioral OF or_gate IS

BEGIN
    PROCESS (or_input) IS BEGIN
        CASE(or_input) IS
            WHEN "00" => or_out <= '0';
            WHEN OTHERS => or_out <= '1';
        END CASE;
    END PROCESS;

END Behavioral;
