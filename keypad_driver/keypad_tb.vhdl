--------------------------------------------------------------------------------
-- Filename : keypad_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: keypad tb
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : This file implements a simple testbench
-- for our keypad driver design
-- Additional Comments: to get the most out of the simulation it is advisable
-- to multiply the input frequencies of the dividers by 100, this will decrease
-- the time needed to see the results in the simulation as well as the memory
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY keypad_tb IS
-- empty
END keypad_tb;

ARCHITECTURE Behavioral OF keypad_tb IS

    SIGNAL clock          : STD_LOGIC                     := '0';
    SIGNAL row            : STD_LOGIC_VECTOR(3 DOWNTO 0)  := "0000";
    SIGNAL column         : STD_LOGIC_VECTOR(3 DOWNTO 0)  := "0000";
    SIGNAL display_select : STD_LOGIC                     := '0';
    SIGNAL locked         : STD_LOGIC                     := '0';
    SIGNAL leds           : STD_LOGIC_VECTOR(3 DOWNTO 0)  := (OTHERS => '0');
    SIGNAL segments       : STD_LOGIC_VECTOR (6 DOWNTO 0) := "0000000";

    -- I'm using indirect instantiation here as an example
    COMPONENT keypad_driver IS
        PORT (
            clock          : IN STD_LOGIC                     := '0';
            row            : IN STD_LOGIC_VECTOR(3 DOWNTO 0)  := "UUUU";
            column         : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "UUUU";
            display_select : OUT STD_LOGIC                    := '0';
            locked         : OUT STD_LOGIC;
            leds           : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            segments       : OUT STD_LOGIC_VECTOR (6 DOWNTO 0) := "0000000"
        );
    END COMPONENT;

BEGIN
    DUT : keypad_driver PORT MAP(clock => clock, row => row, column => column, display_select => display_select, segments => segments);

    clock_process : PROCESS (clock)
    BEGIN
        clock <= NOT clock AFTER 4 ns;
    END PROCESS;

    stimulus : PROCESS
    BEGIN
        WAIT FOR 26 us;
        WAIT FOR 150 ns;
        row <= "0111";
        WAIT FOR 25 us;
        row <= "0000";
        WAIT FOR 15 us;
        WAIT;
    END PROCESS;
END;
