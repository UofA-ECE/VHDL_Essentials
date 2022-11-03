----------------------------------------------------------------------------------
-- Filename : monotonic_counter_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: monotonic_counter_tb
-- Module Name: monotonic counter
-- Project Name: VHDL_essentials
-- Description : Example of a testbench for a monotonic counter  with reset
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY monotonic_counter_tb IS
	-- empty
END monotonic_counter_tb;

ARCHITECTURE Behavioral OF monotonic_counter_tb IS

	SIGNAL count        : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL clock, reset : STD_LOGIC := '0';

BEGIN
	-- Using direct entity instantiation
	UUT : ENTITY work.monotonic_counter(Behavioral) GENERIC MAP(STOP_COUNT => 88) PORT MAP(reset => reset, clock => clock, count => count);

	-- this process creates an artifitial clock with a 4 ns period
	clock_process : PROCESS (clock)
	BEGIN
		clock <= NOT clock AFTER 2 ns;
	END PROCESS;

	PROCESS
	BEGIN
		-- initial reset
		reset <= '1';
		WAIT FOR 5 ns;
		-- start of test
		reset <= '0';
		WAIT FOR 500 ns;
		WAIT;
	END PROCESS;

END Behavioral;
