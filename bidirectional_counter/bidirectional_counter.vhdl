----------------------------------------------------------------------------------
-- Filename : bidirectional_counter.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: bidirectional_counter
-- Module Name: sequential circuits
-- Project Name: VHDL_essentials
-- Description : Implementation of a bidirectional counter using a clock divider
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY bidirectional_counter IS
    PORT (
        direction : IN STD_LOGIC := '1';
        reset     : IN STD_LOGIC := '0';
        clock     : IN STD_LOGIC;
        clock_out : OUT STD_LOGIC;
        count     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"
    );
END ENTITY bidirectional_counter;

ARCHITECTURE Behavioral OF bidirectional_counter IS

    SIGNAL n       : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL clk_out : STD_LOGIC                    := '0';
    SIGNAL counter : INTEGER                      := 0;

BEGIN
    -- direct assignment
    count     <= n;
    clock_out <= clk_out;

    -- here we will define our clock divider
    clock_divider : PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            -- IMPORTANT: FOR IMPLEMENTATION ON THE BOARD CHANGE THE VALUE 2 TO 62500000
            -- This is because the inner FPGA clock we're using is 125 MHz.
            -- So counting 62500000 cycles will give us a 1Hz output signal
            IF counter < 2 THEN
                counter <= counter + 1;
            ELSE
                counter <= 0;
                clk_out <= NOT clk_out;
            END IF;
        END IF;
    END PROCESS;

    -- this process will be triggered by the clock divider output
    PROCESS (clk_out)
    BEGIN
        IF rising_edge(clk_out) THEN
            -- first we check the direction of the counter
            -- and then we make the appropriate decision
            -- about what the next value should be
            -- depending on the current value of the counter
            -- and the state of the reset input
            IF direction = '1' THEN
                IF n = "1111" OR reset = '1' THEN
                    n <= "0000";
                ELSE
                    n <= STD_LOGIC_VECTOR(unsigned(n) + 1);
                END IF;
            ELSE
                IF n = "0000" OR reset = '1' THEN
                    n <= "1111";
                ELSE
                    n <= STD_LOGIC_VECTOR(unsigned(n) - 1);
                END IF;
            END IF;

        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;
