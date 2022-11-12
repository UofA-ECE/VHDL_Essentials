----------------------------------------------------------------------------------
-- Filename : logic_unit.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 04-Nov-10-2022
-- Design Name: logic unit
-- Module Name: Hack ALU
-- Project Name: VHDL_essentials
-- Description : In this file we implement a simple logic unit with four logic operations
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY logic_unit IS
    PORT (
        a   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        b   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        op0 : IN STD_LOGIC;
        op1 : IN STD_LOGIC;
        y   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF logic_unit IS

    SIGNAL operation : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
    operation <= op1 & op0;

    WITH operation SELECT
        y <= a AND b         WHEN "00",
             a OR b          WHEN "01",
             a XOR b         WHEN "10",
             NOT a           WHEN "11",
             (OTHERS => 'X') WHEN OTHERS;
END;
