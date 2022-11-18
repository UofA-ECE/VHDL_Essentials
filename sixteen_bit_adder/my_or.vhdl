----------------------------------------------------------------------------------
-- Filename : my_or.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-2022
-- Design Name: or gate
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : Basic Or gate
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_or IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY my_or;

ARCHITECTURE Behavioral OF my_or IS

BEGIN
    -- direct assignment using the OR function
    y <= a OR b;
END Behavioral;
