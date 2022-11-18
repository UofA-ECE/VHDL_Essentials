--------------------------------------------------------------------------------
-- Filename : my_half_adder.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-2022
-- Design Name: my_half_adder
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file we create a half adder entity
-- with a simple behavioral and structural architectures
-- approaches and methodologies
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_half_adder IS
    PORT (
        -- a and b represent our input bits
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        -- h and l represent the MSB and LSB of the result
        h : OUT STD_LOGIC;
        l : OUT STD_LOGIC
    );
END ENTITY my_half_adder;

ARCHITECTURE Behavioral OF my_half_adder IS

BEGIN
    -- gate level logic using functions
    h <= a AND b;
    l <= a XOR b;
END;

ARCHITECTURE Structural OF my_half_adder IS

BEGIN
    -- logic is already implemented by the lower hierarchy entities
    -- here we just want to map the signals to the appropriate ports
    and_1: entity work.my_and(Behavioral) port map(a=>a,b=>b,y=>h);
    xor_1: entity work.my_xor(Behavioral) port map(a=>a,b=>b,y=>l);
END;
