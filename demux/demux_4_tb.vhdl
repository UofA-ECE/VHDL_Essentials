----------------------------------------------------------------------------------
-- Filename : demux_4_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: demux_tb
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : Testbench for 1:4 demultiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY demux_4_tb IS
    --  empty
END demux_4_tb;

ARCHITECTURE Behavioral OF demux_4_tb IS
    SIGNAL d    : STD_LOGIC                    := '1';
    SIGNAL sel  : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL dmux : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    -- Direct entity instantiation
    DUT : ENTITY work.demux_4(Behavioral) PORT MAP(d => d, sel => sel, dmux => dmux);

    stimulus : PROCESS
    BEGIN
        WAIT FOR 2 ns;
        sel <= "01";
        WAIT FOR 2 ns;
        sel <= "10";
        WAIT FOR 2 ns;
        sel <= "11";
        WAIT FOR 2 ns;
        sel <= "10";
        WAIT FOR 2 ns;
        sel <= "01";
        WAIT FOR 2 ns;
        sel <= "00";
        WAIT FOR 2 ns;
        WAIT;
    END PROCESS;
END Behavioral;
