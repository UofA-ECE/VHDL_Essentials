----------------------------------------------------------------------------------
-- Filename : logic_unit_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 04-Nov-10-2022
-- Design Name: logic unit
-- Module Name: Hack ALU
-- Project Name: VHDL_essentials
-- Description : In this file we implement a simple testbench for our logic unit
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY logic_unit_tb IS
END ENTITY;

ARCHITECTURE Behavioral OF logic_unit_tb IS

    SIGNAL operation : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal a: STD_LOGIC_VECTOR(15 DOWNTO 0):=(others => '1');
    signal b: STD_LOGIC_VECTOR(15 DOWNTO 0):="0101010101010101";
    signal y: STD_LOGIC_VECTOR(15 DOWNTO 0);
    
BEGIN
    DUT: entity work.logic_unit(Behavioral) port map(a=>a,b=>b,op0=>operation(0),op1=>operation(1),y=>y);
    stimulus: process
    begin
        operation <= "00";
        wait for 2 ns;
        operation <= "01";
        wait for 2 ns;
        operation <= "10";
        wait for 2 ns;
        operation <= "11";
        wait for 2 ns;
        wait;
    end process;
END;
