----------------------------------------------------------------------------------
-- Filename : demux.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: demux
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : 1:2 demultiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity demux is
    port(
        d: in std_logic;
        sel: in std_logic;
        dmux0, dmux1: out std_logic
    );
end entity demux;

architecture Behavioral of demux is

begin
    dmux0 <= d when sel = '0' else '0';
    dmux1 <= d when sel = '1' else '0';
end Behavioral;
