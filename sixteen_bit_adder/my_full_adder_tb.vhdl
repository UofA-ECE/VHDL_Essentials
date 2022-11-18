--------------------------------------------------------------------------------
-- Filename : my_full_adder_tb.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 28-Oct-2022
-- Design Name: my_full_adder_tb
-- Module Name: Combinational Circuits
-- Project Name: VHDL_essentials
-- Description : basic testbench for a full adder circuit
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY my_full_adder_tb IS
END my_full_adder_tb;

ARCHITECTURE Behavioral OF my_full_adder_tb IS

    SIGNAL a, b, Cin                                       : STD_LOGIC := '0';
    SIGNAL Cout1, Cout2, Cout3, Cout4, Cout5, Cout6, Cout7 : STD_LOGIC := '0';
    SIGNAL sum1, sum2, sum3, sum4, sum5, sum6, sum7        : STD_LOGIC := '0';
    SIGNAL adder_input                                     : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL int_a, int_b, int_s                             : INTEGER;

BEGIN
    -- direct entity instantiation
    rtl     : ENTITY work.my_full_adder(rtl) PORT MAP(a => a, b => b, Cin => Cin, sum => sum1, Cout => Cout1);
    logic   : ENTITY work.my_full_adder(logic) PORT MAP(a => a, b => b, Cin => Cin, sum => sum2, Cout => Cout2);
    Behav   : ENTITY work.my_full_adder(Behavioral) PORT MAP(a => a, b => b, Cin => Cin, sum => sum3, Cout => Cout3);
    Struct  : ENTITY work.my_full_adder(Structural) PORT MAP(a => a, b => b, Cin => Cin, sum => sum4, Cout => Cout4);
    Struct2 : ENTITY work.my_full_adder(Structural_2) PORT MAP(a => a, b => b, Cin => Cin, sum => sum5, Cout => Cout5);
    Hybrid  : ENTITY work.my_full_adder(Hybrid) PORT MAP(a => a, b => b, Cin => Cin, sum => sum6, Cout => Cout6);
    Hybrid2 : ENTITY work.my_full_adder(Hybrid_2) PORT MAP(a => a, b => b, Cin => Cin, sum => sum7, Cout => Cout7);
    
    -- sending values to the input ports
    a   <= adder_input(2);
    b   <= adder_input(1);
    Cin <= adder_input(0);

    -- cycle through all possible input combinations
    STIMULUS : PROCESS
    BEGIN
        FOR i IN 0 TO 7 LOOP
            adder_input <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, adder_input'length));
            WAIT FOR 10 NS;
        END LOOP;
        WAIT;
        WAIT;
    END PROCESS;
END Behavioral;
