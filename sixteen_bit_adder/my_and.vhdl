--------------------------------------------------------------------------------
-- Filename : my_and.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-2022
-- Design Name: and gate
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : Basic And gate
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_and IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY my_and;

ARCHITECTURE Behavioral OF my_and IS

BEGIN
    -- direct assignment using the AND function
    y <= a AND b;
END Behavioral;
