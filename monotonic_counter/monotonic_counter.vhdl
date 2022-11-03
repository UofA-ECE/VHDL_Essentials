----------------------------------------------------------------------------------
-- Filename : monotonic_counter.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: monotonic_counter
-- Module Name: monotonic counter
-- Project Name: VHDL_essentials
-- Description : Example of a monotonic binary counter  with reset
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY monotonic_counter IS
	-- Here we are using the generic as an example for defining the count limit
	GENERIC (STOP_COUNT : NATURAL := 9);
	PORT (
		reset : IN STD_LOGIC;
		clock : IN STD_LOGIC;
		count : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY monotonic_counter;

ARCHITECTURE Behavioral OF monotonic_counter IS
	-- this signal will hold the value of the counter
	SIGNAL n : NATURAL := 0;

BEGIN
	-- Our signal n is of type natural so we need to change it to std_logic_vector
	-- before assigning its value to count
	count <= STD_LOGIC_VECTOR(to_unsigned(n, count'length));

	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			-- counter resets itself when STOP_COUNT value is reached or reset is equal to 1
			IF n = STOP_COUNT OR reset = '1' THEN
				n <= 0;
			ELSE
				n <= n + 1;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE Behavioral;
