----------------------------------------------------------------------------------
-- Filename : display_controller.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: display controller
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement a design that can read two 4 bit
-- characters from a register and show it on the appropriate seven segments display
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY display_controller IS
	PORT (
		-- read in digits, the 4 MSBs represent the first digit
		-- the last LSBs represent, the sencond digit
		digits : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock  : IN STD_LOGIC;
		-- Controls which of the seven segment displays is active
		display_select : OUT STD_LOGIC := '0';
		--controls which digit to display
		segments : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
END display_controller;

ARCHITECTURE Behavioral OF display_controller IS
	-- this signal will get the value of the character to display
	SIGNAL digit : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

	display_select <= clock;

	WITH clock SELECT
		digit <= digits(7 DOWNTO 4) WHEN '1',
		digits(3 DOWNTO 0) WHEN OTHERS;

	-- the zybo z7 Pmod SSD: Seven Segment Display
	-- is attached to the board in such a way that
	-- the characters look upside down if we follow the
	-- mapping from the manual, for this reason we use
	-- a different mapping that solves this problem.
	WITH digit SELECT -- segments "ABCDEFG" 
		segments <= "1111110" WHEN "0000", --0
					"0000110" WHEN "0001", --1
					"1101101" WHEN "0010", --2
					"1001111" WHEN "0011", --3
					"0010111" WHEN "0100", --4
					"1011011" WHEN "0101", --5
					"1111011" WHEN "0110", --6
					"0001110" WHEN "0111", --7
					"1111111" WHEN "1000", --8
					"1011111" WHEN "1001", --9
					"0111111" WHEN "1010", --A
					"1110011" WHEN "1011", --B
					"1111000" WHEN "1100", --C
					"1100111" WHEN "1101", --D
					"1111001" WHEN "1110", --E
					"0111001" WHEN "1111", --F
					"0000000" WHEN OTHERS;
END Behavioral;
