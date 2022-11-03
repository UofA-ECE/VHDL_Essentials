----------------------------------------------------------------------------------
-- Filename : mux_4_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: mux_4_tb
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : Testbench for 4:1 multiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux_4_tb IS
    --  empty
END mux_4_tb;

ARCHITECTURE Behavioral OF mux_4_tb IS

    SIGNAL d0, d1, d2, d3, mux_out : STD_LOGIC                    := '0';
    SIGNAL sel                     : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

BEGIN
    -- Direct entity instantiation
    DUT : ENTITY work.mux_4(Behavioral) PORT MAP(d0 => d0, d1 => d1, d2 => d2, d3 => d3, sel => sel, mux_out => mux_out);

    stimulus : PROCESS
    BEGIN
        WAIT FOR 2 ns;
        d0 <= '1';
        d1 <= '0';
        d2 <= '1';
        d3 <= '0';
        WAIT FOR 2 ns;
        sel <= "01";
        WAIT FOR 2 ns;
        sel <= "10";
        WAIT FOR 2 ns;
        sel <= "11";
        WAIT FOR 2 ns;
        d0  <= '0';
        d1  <= '1';
        d2  <= '0';
        d3  <= '1';
        sel <= "00";
        WAIT FOR 2 ns;
        sel <= "01";
        WAIT FOR 2 ns;
        sel <= "10";
        WAIT FOR 2 ns;
        sel <= "11";
        WAIT FOR 2 ns;
        WAIT;
    END PROCESS;
END Behavioral;
