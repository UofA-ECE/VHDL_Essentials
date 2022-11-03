----------------------------------------------------------------------------------
-- Filename : blinky.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: Blinky
-- Module Name: Blinky
-- Project Name: VHDL_essentials
-- Description : In this file we show a basic implementation of a clock divider using a counter
-- in order to make a blinking led
-- Additional Comments: testbench, constraint file and bitstream files included
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY blinky IS
    PORT (
        blink         : IN STD_LOGIC;
        clock         : IN STD_LOGIC;
        clock_divider : OUT STD_LOGIC;
        led           : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Behavioral OF blinky IS
    -- this signal represents the output of our clock divider
    SIGNAL clk_out : STD_LOGIC := '0';
    -- this signal will hold the counter value
    SIGNAL count   : INTEGER   := 0;

BEGIN

    clock_divider <= clk_out;


    -- We will implement a clock divider using a process and a signal to keep track of the current counter value
    divider : PROCESS (clock) -- this process gets trigered every time the input clock changes value
    BEGIN
        -- on every rising edge of the clock increment the count by one or reset it
        IF rising_edge(clock) THEN
            -- the Zybo z7 board has a 125 MHz inner clock with a period of 8 ns 
            -- for a 1 Hz output we can simply divide 125 MHz by 2 and set the result
            -- as our count limit
            IF count < 62500000 THEN
                count <= count + 1;
            ELSE
                -- if the limit has been reached reset the counter
                count   <= 0;
                -- change the state of the output
                clk_out <= NOT clk_out;
            END IF;
        END IF;
    END PROCESS;

    -- this will be our main process that sets the value of the blinking led
    PROCESS (clk_out)
    BEGIN
        IF blink = '1' THEN
            led <= clk_out;
        ELSE
            led <= '0';
        END IF;
    END PROCESS;
END;
