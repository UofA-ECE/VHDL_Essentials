-----------------------------------------------------------------------------------
-- Filename : my_or.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: or gate
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we go over the process of declaring the architecture
-- of a basic And gate including a testbench and constraint file for implementing on the Zybo Z7 board.
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
-----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_and IS
    PORT (
        -- gate inputs
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        -- gate output
        y : OUT STD_LOGIC
    );
END ENTITY my_and;

ARCHITECTURE Behavioral OF my_and IS

BEGIN
    -- direct assignment using the AND function
    y <= a OR b;
END Behavioral;
