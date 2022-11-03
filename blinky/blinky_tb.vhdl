----------------------------------------------------------------------------------
-- Filename : blinky_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: Blinky
-- Module Name: Blinky
-- Project Name: VHDL_essentials
-- Description : This is a testbench for the blinking led circuit from blinky.vhdl
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY blinky_tb IS
END ENTITY;

ARCHITECTURE Behavioral OF blinky_tb IS
  SIGNAL blink, clock, clock_divider, led : STD_LOGIC := '0';
BEGIN

  DUT : ENTITY work.blinky(Behavioral) PORT MAP(blink => blink, clock => clock, clock_divider => clock_divider, led => led);

  clock_process : PROCESS (clock)
  BEGIN
    clock <= NOT clock AFTER 4 ns;
  END PROCESS;

  stimulus : PROCESS
  BEGIN
    WAIT FOR 5 ns;
    blink <= '1';
    WAIT FOR 50 ns;
    blink <= '0';
    WAIT FOR 50 ns;
    blink <= '1';
    WAIT FOR 50 ns;
    blink <= '0';
    WAIT FOR 50 ns;
    WAIT;
  END PROCESS;
END;
