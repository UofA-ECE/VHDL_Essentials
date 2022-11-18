--------------------------------------------------------------------------------
-- Filename : my_sixteen_bit_adder_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-2022
-- Design Name: my_sixteen_bit_adder_tb
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : In this file write a simple testbench for a 16 bit adder
-- Additional Comments: since the amount of possible combinations is too big
-- in order to test every individual case instead we just focus some edge cases
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY my_sixteen_bit_adder_tb IS
END ENTITY my_sixteen_bit_adder_tb;

ARCHITECTURE Behavioral OF my_sixteen_bit_adder_tb IS
    SIGNAL Cin, Cout_1, Cout_2 : STD_LOGIC := '0';
    SIGNAL sum_1, sum_2        : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL a_input, b_input    : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
    -- instantiation of different architectures for simultaneous testing
    DUT_1 : ENTITY work.my_sixteen_bit_adder(Structural) PORT MAP(a => a_input, b => b_input, sum => sum_1, Cin => Cin, Cout => Cout_1);
    DUT_2 : ENTITY work.my_sixteen_bit_adder(Structural_2) PORT MAP(a => a_input, b => b_input, sum => sum_2, Cin => Cin, Cout => Cout_2);

    STIMULUS : PROCESS
    BEGIN
        Cin <= '0';
        FOR i IN 65500 TO 65535 LOOP
            b_input <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, b_input'length));
            FOR j IN 0 TO 100 LOOP
                a_input <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, a_input'length));
                WAIT FOR 1 NS;
            END LOOP;
        END LOOP;

        Cin <= '1';
        FOR i IN 65500 TO 65535 LOOP
            b_input <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, b_input'length));
            FOR j IN 65435 TO 65535 LOOP
                a_input <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, a_input'length));
                WAIT FOR 1 NS;
            END LOOP;
        END LOOP;
        WAIT;
    END PROCESS;
END Behavioral;
