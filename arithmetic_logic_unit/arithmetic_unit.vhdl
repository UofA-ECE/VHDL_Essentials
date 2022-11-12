----------------------------------------------------------------------------------
-- Filename : arithmetic_unit.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 04-Nov-10-2022
-- Design Name: arithmetic unit
-- Module Name: Hack ALU
-- Project Name: VHDL_essentials
-- Description : In this file we implement a simple arithmetic unit with four operations
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY arithmetic_unit IS
    PORT (
        a   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        b   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        op0 : IN STD_LOGIC;
        op1 : IN STD_LOGIC;
        y   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF arithmetic_unit IS

    SIGNAL operation : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
    operation <= op1 & op0;

    WITH operation SELECT
        y <=STD_LOGIC_VECTOR(unsigned(a) + unsigned(b)) WHEN "00",
            STD_LOGIC_VECTOR(unsigned(a) - unsigned(b)) WHEN "01",
            STD_LOGIC_VECTOR(unsigned(a) + 1)           WHEN "10",
            STD_LOGIC_VECTOR(unsigned(a) - 1)           WHEN "11",
            (OTHERS => 'X')                             WHEN OTHERS;
END;
