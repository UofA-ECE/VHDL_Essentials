----------------------------------------------------------------------------------
-- Filename : demux_4.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-10-2022
-- Design Name: 1:4 demux
-- Module Name: combinational circuits
-- Project Name: VHDL_essentials
-- Description : 1:4 demultiplexer
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY demux_4 IS
    PORT (
        d    : IN STD_LOGIC;
        sel  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        dmux : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY demux_4;

ARCHITECTURE Behavioral OF demux_4 IS

BEGIN
    PROCESS (sel)
    BEGIN
        CASE (sel) IS
            WHEN "00" => dmux   <= (0 => d, OTHERS => '0');
            WHEN "01" => dmux   <= (1 => d, OTHERS => '0');
            WHEN "10" => dmux   <= (2 => d, OTHERS => '0');
            WHEN "11" => dmux   <= (3 => d, OTHERS => '0');
            WHEN OTHERS => dmux <= (OTHERS => 'X');
        END CASE;
    END PROCESS;
END Behavioral;
