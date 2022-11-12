----------------------------------------------------------------------------------
-- Filename : mux_4.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: mux_4
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : Example of a 4:1 multiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux_4 IS
    PORT (
        d0, d1, d2, d3 : IN STD_LOGIC;
        sel            : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        mux_out        : OUT STD_LOGIC
    );
END ENTITY mux_4;

ARCHITECTURE Behavioral OF mux_4 IS
BEGIN
    WITH (sel) SELECT
    mux_out <= d0 WHEN "00",
        d1 WHEN "01",
        d2 WHEN "10",
        d3 WHEN "11",
        'X' WHEN OTHERS;
END Behavioral;
