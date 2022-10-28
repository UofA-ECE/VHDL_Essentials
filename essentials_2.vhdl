----------------------------------------------------------------------------------
-- Filename : essentials_2.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: entity_declaration
-- Module Name: black_box
-- Project Name: VHDL_essentials
-- Description : In this file we go over the process of declaring an entity in different ways using VHDL
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : MIT
----------------------------------------------------------------------------------


-- **************************************************************************** --
-- **************************** IMPORTANT ************************************* --
-- **************************************************************************** --
-- *                                                                          * --
-- *            This file is not valid VHDL code on it's own,                 * --
-- *                    it's only meant as an example for                     * --
-- *                        the entity declaration                            * --
-- *                                                                          * --
-- **************************************************************************** --
-- **************************** IMPORTANT ************************************* --
-- **************************************************************************** --


-- On the first part we wrote the entity declaration for this black box circuit using different types,
-- on this file we will continue exploring different ways of writing our entity declaration using other types.
--          -------    5
--      5  |       |--/-- Out0
-- I0 --/--| black |----- Out1
-- I1 --/--|  box  |----- Out2
--     3   |       |
--          -------

-- On our last example we wrote our entity declaration using the std_logic type,
-- we will now rewrite it usign the integer type (assuming positive integers)
ENTITY black_box IS
    PORT(
        -- input ports
        I0: IN integer RANGE 0 to 31; -- we can switch between the integer and binary representation depending on our design
        I1: IN integer RANGE 0 to 7;  -- the range 0 to 7 corresponds to a bit vector of length 3
        -- output ports
        Out0:OUT integer RANGE 0 to 31;
        Out1:OUT integer RANGE 0 to 1; -- bassically represents a bit
        Out2:OUT integer RANGE 0 to 1
        );
END black_box; -- END of ENTITY


-- Using positive and negative integers our entity declaration looks like this
-- integers use a standard 32 bit representation that can range from -2147483647 to 2147483647
ENTITY black_box IS
    PORT(
        -- input ports
        I0: IN integer RANGE -16 TO 15;
        I1: IN integer RANGE -4 TO 3; 
        -- output ports
        Out0:OUT integer RANGE -16 TO 15;
        Out1:OUT integer RANGE 0 TO 1;
        Out2:OUT integer RANGE 0 TO 1
        );
END black_box; -- END of ENTITY


-- using natural (a subset of the integer type that start from 0 to 2147483647)
ENTITY black_box is
    PORT(
        -- input ports
        I0: IN natural RANGE 0 TO 31;
        I1: IN natural RANGE 0 TO 7; 
        -- output ports
        Out0:OUT natural RANGE 0 TO 31;
        Out1:OUT natural RANGE 0 TO 1;
        Out2:OUT natural RANGE 0 TO 1
        );
END black_box; -- END of ENTITY


-- using positive (a subset of the integer type)
ENTITY black_box is
    PORT(
        -- input ports
        I0: IN positive RANGE 1 TO 32;
        I1: IN positive RANGE 1 TO 8; 
        -- output ports
        Out0:OUT positive RANGE 1 TO 32;
        Out1:OUT positive RANGE 1 TO 2;
        Out2:OUT positive RANGE 1 TO 2
        );
END black_box; -- END of ENTITY


-- using the unsigned type (same as natural ranges from 0 to 2147483647)
LIBRARY IEEE;
use IEEE.numeric_std.all;
ENTITY black_box IS
    PORT(
        -- input ports
        I0: IN unsigned(4 DOWNTO 0); -- represent using bits
        I1: IN unsigned(2 DOWNTO 0); 
        -- output ports
        Out0:OUT unsigned(4 DOWNTO 0);
        Out1:OUT unsigned;
        Out2:OUT unsigned
        );
END black_box;


-- using signed
LIBRARY IEEE;
USE IEEE.numeric_std.all;
ENTITY black_box is
    PORT(
        -- input ports
        I0: IN signed(4 DOWNTO 0); -- represent using bits
        I1: IN signed(2 DOWNTO 0); 
        -- output ports
        Out0:OUT signed(4 DOWNTO 0);
        Out1:OUT signed;
        Out2:OUT signed
        );
END black_box;
