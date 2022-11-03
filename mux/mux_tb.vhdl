----------------------------------------------------------------------------------
-- Filename : mux_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: mux_tb
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : Testbench for 2:1 multiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY mux_tb IS
    --  empty
END mux_tb;

ARCHITECTURE Behavioral OF mux_tb IS
    SIGNAL d0, d1, sel, mux_out : STD_LOGIC := '0';
BEGIN
    -- Direct entity instantiation
    DUT : ENTITY work.mux(Behavioral) PORT MAP(d0 => d0, d1 => d1, sel => sel, mux_out => mux_out);

    stimulus : PROCESS
    BEGIN
        WAIT FOR 2 ns;
        d0 <= '1';
        WAIT FOR 2 ns;
        sel <= '1';
        WAIT FOR 2 ns;
        sel <= '0';
        WAIT FOR 2 ns;
        d0 <= '1';
        WAIT FOR 2 ns;
        d0  <= '0';
        sel <= '1';
        WAIT FOR 2 ns;
        d1 <= '1';
        WAIT FOR 2 ns;
        WAIT;
    END PROCESS;
END Behavioral;
