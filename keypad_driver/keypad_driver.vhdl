----------------------------------------------------------------------------------
-- Filename : keypad_driver.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: keypad driver
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement a design that can read, store,
-- and display the values coming in from a 4x4 matrix keypad
-- Additional Comments: for this design we will use two clock dividers (one for
-- the keypad decoder and one for the display driver), an 8 bit register that
-- will store the last 2 received values and a display controller that will
-- show the contents of the register on the 7 segments diplays
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY keypad_driver IS
    PORT (
        clock          : IN STD_LOGIC := '1';
        row            : IN STD_LOGIC_VECTOR(3 DOWNTO 0);            -- keypad rows "123A" "456B" "789C" "0FED"
        column         : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111"; -- keypad columns "1470" "258F" "369E" "ABCD"
        display_select : OUT STD_LOGIC;                              -- Controls which of the seven segment displays is active
        locked         : OUT STD_LOGIC;                              -- if '1' the keypad value is locked
        leds           : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        segments       : OUT STD_LOGIC_VECTOR (6 DOWNTO 0) -- active segments on the seven segment display 
        );
END keypad_driver;

ARCHITECTURE Structural OF keypad_driver IS
    SIGNAL decoder_clock, display_clock : STD_LOGIC;
    SIGNAL value                        : STD_LOGIC_VECTOR (4 DOWNTO 0);
    SIGNAL digits                       : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
    -- main components
    keypad_decoder    : ENTITY WORK.keypad_decoder(Behavioral) PORT MAP (clock=>decoder_clock,row=>row,column=>column,data_out=>value);
    keypad_register   : ENTITY WORK.keypad_register(Behavioral) PORT MAP (locked=>locked,value=>value,clock=>decoder_clock,digits=>digits);
    keypad_display    : ENTITY WORK.display_controller(Behavioral) PORT MAP (digits=>digits,clock=>display_clock,display_select=>display_select,segments=>segments);
    -- clock dividers (multiply frequencies by 1000 when simulating in order to save memory and time)
    decoder_div : ENTITY WORK.clock_divider(Behavioral) GENERIC MAP (freq_out => 10000000) PORT MAP(clock=>clock,clock_div=>decoder_clock);
    display_div : ENTITY WORK.clock_divider(Behavioral) GENERIC MAP (freq_out => 500000) PORT MAP(clock=>clock,clock_div=>display_clock);
    -- this will show the value read byt the keypad value on the leds in real time
    leds <= value(3 DOWNTO 0);
END;
