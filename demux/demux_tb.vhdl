----------------------------------------------------------------------------------
-- Filename : demux_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: demux_tb
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : Testbench for 1:2 demultiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY demux_tb IS
    --  empty
END demux_tb;

ARCHITECTURE Behavioral OF demux_tb IS
    SIGNAL d, sel, dmux0, dmux1 : STD_LOGIC := '0';
BEGIN
    -- Direct entity instantiation
    DUT : ENTITY work.demux(Behavioral) PORT MAP(d => d, sel => sel, dmux0 => dmux0, dmux1=>dmux1);

    stimulus : PROCESS
    BEGIN
        d <= '1';
        WAIT FOR 2 ns;
        sel <= '1';
        WAIT FOR 2 ns;
        d <= '0';
        WAIT FOR 2 ns;
        sel <= '0';
        WAIT FOR 2 ns;
        d <= '1';
        WAIT FOR 2 ns;
        WAIT;
    END PROCESS;
END Behavioral;
