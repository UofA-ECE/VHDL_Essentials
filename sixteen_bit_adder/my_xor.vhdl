--------------------------------------------------------------------------------
-- Filename : my_xor.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-2022
-- Design Name: xor gate
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : Basic Xor gate
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_xor IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY my_xor;

ARCHITECTURE Behavioral OF my_xor IS

BEGIN
    -- direct assignment using the XOR function
    y <= a XOR b;
END Behavioral;
