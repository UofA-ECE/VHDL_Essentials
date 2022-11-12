----------------------------------------------------------------------------------
-- Filename : hack_alu.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 04-Nov-10-2022
-- Design Name: ALU
-- Module Name: Hack ALU
-- Project Name: VHDL_essentials
-- Description : In this file we implement a 16 bit ALU desiigned for the hack computer
-- Additional Comments: 
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY hack_alu IS
    PORT (
        zx      : IN STD_LOGIC            := '0';
        zy      : IN STD_LOGIC            := '0';
        nx      : IN STD_LOGIC            := '0';
        ny      : IN STD_LOGIC            := '0';
        f       : IN STD_LOGIC            := '0';
        no      : IN STD_LOGIC            := '0';
        x       : IN signed(15 DOWNTO 0)  := (OTHERS => '0');
        y       : IN signed(15 DOWNTO 0)  := (OTHERS => '0');
        ALU_out : OUT signed(15 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY;

ARCHITECTURE Behavioral OF hack_alu IS
    -- we will use an auxuliary signal to store the result of the ALU operation
    SIGNAL aux         : signed(15 DOWNTO 0);

    -- this signal will help to code each operation individually with ease
    SIGNAL alu_Address : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
    
    -- concatenating all flags into one vector
    alu_address <= zx&nx&zy&ny&f&no;

    -- direct asigntment of ALU_out
    ALU_out     <= aux;

    WITH alu_address SELECT
        -- since all the ALU operations can be expressed in one line we use a with statement
        -- to describe the behavior of the hack ALU
        aux <= (OTHERS => '0')      WHEN "101010",
        (0 => '1', OTHERS => '0')   WHEN "111111",
        (OTHERS        => '1')      WHEN "111010",
        x                           WHEN "001100",
        y                           WHEN "110000",
        NOT x                       WHEN "001101",
        NOT y                       WHEN "110001",
        -x                          WHEN "001111",
        -y                          WHEN "110011",
        x + 1                       WHEN "011111",
        y + 1                       WHEN "110111",
        x - 1                       WHEN "001110",
        y - 1                       WHEN "110010",
        x + y                       WHEN "000010",
        x - y                       WHEN "010011",
        y - x                       WHEN "000111",
        x AND y                     WHEN "000000",
        x OR y                      WHEN "010101",
        (OTHERS => 'Z')             WHEN OTHERS;
END Behavioral;



-- another way of expressing the same logic inside a process and a case statement
ARCHITECTURE Behavioral_2 OF hack_alu IS
    SIGNAL aux         : signed(15 DOWNTO 0);
    SIGNAL alu_Address : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
    
    alu_address <= zx&nx&zy&ny&f&no;
    ALU_out     <= aux;

    process(x,y,alu_Address)
    begin
    case (alu_address) is
        when "101010" => aux <= (others=>'0');
        when "111111" => aux <= (0=>'1', others=>'0');
        when "111010" => aux <= (others=>'1');
        when "001100" => aux <= x;
        when "110000" => aux <= y;
        when "001101" => aux <= not x;
        when "110001" => aux <= not y;
        when "001111" => aux <= not x + 1;
        when "110011" => aux <= not y + 1;
        when "011111" => aux <= x + 1;
        when "110111" => aux <= y + 1;
        when "001110" => aux <= x - 1;
        when "110010" => aux <= y - 1;
        when "000010" => aux <= x + y;
        when "010011" => aux <= x - y;
        when "000111" => aux <= y - x;
        when "000000" => aux <= x and y;
        when "010101" => aux <= x or y;
        when others => aux <= (others =>'Z');
    end case;
    end process;
END Behavioral_2;