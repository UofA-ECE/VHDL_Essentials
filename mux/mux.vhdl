----------------------------------------------------------------------------------
-- Filename : mux.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: mux
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : Example of a 2:1 multiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux IS
    PORT (
        d0, d1  : IN STD_LOGIC;
        sel     : IN STD_LOGIC;
        mux_out : OUT STD_LOGIC
    );
END ENTITY mux;

ARCHITECTURE Behavioral OF MUX IS
BEGIN
    mux_out <= d1 WHEN sel = '1' ELSE
        d0;
END Behavioral;
