----------------------------------------------------------------------------------
-- Filename : bidirectional_counter_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: bidirectional_counter
-- Module Name: sequential circuits
-- Project Name: VHDL_essentials
-- Description : Implementation of a testbench for a bidirectional counter
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY bidirectional_counter_tb IS
    -- Empty
END bidirectional_counter_tb;

ARCHITECTURE Behavioral OF bidirectional_counter_tb IS

    SIGNAL direction, reset, clock, clock_out : STD_LOGIC := '1';
    SIGNAL count                   : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Using Component instantiation for the counter
    COMPONENT bidirectional_counter
        PORT (
            direction : IN STD_LOGIC := '1';
            reset     : IN STD_LOGIC := '0';
            clock     : IN STD_LOGIC:='0';
            clock_out : OUT STD_LOGIC:='0';
            count     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    -- creating the component instance
    DUT : bidirectional_counter PORT MAP(direction => direction, reset => reset, clock => clock, clock_out=>clock_out, count => count);

    -- this process will create a clock with an 8 ns period
    clock_process : PROCESS (clock)
    BEGIN
        clock <= NOT clock AFTER 4 ns;
    END PROCESS;

    -- here we manipulate the inputs in order to verify the behavior of our simulated circuit
    Stimulus : PROCESS IS BEGIN
        WAIT FOR 40 ns;
        direction <= '0';
        WAIT FOR 40 ns;
        reset <= '0';
        WAIT FOR 120 ns;
        direction <= '1';
        WAIT FOR 120 ns;
        WAIT;
    END PROCESS;

END Behavioral;
