--------------------------------------------------------------------------------
-- Filename : keypad_press.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 11-Apr-2023
-- Design Name: keypad press
-- Project Name: VHDL_essentials
-- Description : Design for a 4x4 matrix keypad that turns on an led whenever 1 or more keys are pressed
-- Additional Comments: simple implementation to use the entire keypad as an extra input button
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY keypad_press IS
    PORT (
        clock    : IN STD_LOGIC;
        row      : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        column   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0):="0000";
        clk_div: out std_logic;
        data_out : OUT STD_LOGIC);
END keypad_press;


ARCHITECTURE Behavioral OF keypad_press IS
    SIGNAL aux, clock_div  : STD_LOGIC := '0';

BEGIN
    divider: entity work.clock_divider(Behavioral) generic map(freq_out=>100) port map(clock=>clock, clock_div=>clock_div);
    
    data_out <= aux;    
    
    PROCESS (clock_div)
    BEGIN
        IF rising_edge(clock_div) THEN
            aux <= '0';
        if row = "0111" or row = "1011" or row = "1101" or row = "1110" then
            aux <= '1';
        end if;
        END IF;
    END PROCESS;
END Behavioral;