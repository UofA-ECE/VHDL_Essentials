----------------------------------------------------------------------------------
-- Filename : clock_divider.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: clock divider
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement a clock divider, a very useful component
--  and a fundamental block for many projects
-- Additional Comments: Our clock divider will take two generic parameters (the frequencies of the
-- input and output clock signals in Hz) and the output will be the desired output frequency,
-- the divider performs the inner calculation to match the frequencies.
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- the value 2*freq_out must be a divisor of freq_in in
-- order to avoid drifting of the clock signals
ENTITY clock_divider IS
    GENERIC (
        freq_in : INTEGER := 125_000_000; -- input clock frequency in Hz
        freq_out     : INTEGER := 1_000 -- output clock frequency in Hz
        );
    -- examples of integer dividers for the inner clock of the zybo z7 B board:
    -- 1, 2, 4, 5, 8, 10, 16, 20, 25, 32, 40, 50, 80, 100,
    -- 125, 160, 200, 250, 400, 500, 625, 800, 1_000, 1_250,
    -- 2_000, 2_500, 3_125, 4_000, 5_000, 6_250, 10_000, 12_500,
    -- 15_625, 20_000, 25_000, 31_250, 50_000, 62_500,
    -- 78_125, 100_000, 125_000, 156_250, 250_000, 500_000
    PORT (
        clock     : IN STD_LOGIC; -- input clock signal
        clock_div : OUT STD_LOGIC -- output clock signal
        );
END clock_divider;

ARCHITECTURE Behavioral OF clock_divider IS

    -- calculate counter limit
    CONSTANT limit : INTEGER := freq_in/(2*freq_out);

    --signals for the counter
    SIGNAL count        : INTEGER RANGE 1 TO limit:=1; -- set the counter range
    SIGNAL clock_signal : STD_LOGIC := '0';

BEGIN
    clock_div <= clock_signal; -- direct output asignment

    -- this implementation is very straightforward, we want to increment the
    -- counter on every rising edge until it reaches its limit value,
    -- then we reset the counter and flip the value of the output
    PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF count < limit THEN
                count <= count + 1;
            ELSE
                count        <= 1;
                clock_signal <= NOT clock_signal;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;
