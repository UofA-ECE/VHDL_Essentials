--------------------------------------------------------------------------------
-- Filename : keypad_decoder.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: keypad decoder
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : Design for a 4x4 matrix keypad decoder
-- Additional Comments: input clock signal = 1 kHz
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; -- only neccesary if using the rotate function

-- the keypad decoder automatically goes trough the input rows
-- one at a time and checks if the output value of the columns
-- matches with a button.

ENTITY keypad_decoder IS
    PORT (
        clock    : IN STD_LOGIC;
        row      : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        column   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
END keypad_decoder;

ARCHITECTURE Behavioral OF keypad_decoder IS

    SIGNAL sclk : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0111"; -- this sets the initial value for the rows input
    -- if the MSB of this signal is '1' it indicates an invalid character
    SIGNAL aux  : STD_LOGIC_VECTOR (4 DOWNTO 0) := "00000";

BEGIN
    column   <= sclk;
    data_out <= aux;

    PROCESS (clock)
    BEGIN
        IF clock'event AND clock = '1' THEN
            -- scan columns
            CASE sclk IS
                WHEN "0111" => --Column 1
                    CASE row IS
                        WHEN "0111" => aux <= "00001"; --1
                        WHEN "1011" => aux <= "00100"; --4
                        WHEN "1101" => aux <= "00111"; --7
                        WHEN "1110" => aux <= "00000"; --0
                        WHEN OTHERS => aux <= "10000"; -- invalid
                    END CASE;
                WHEN "1011" => --Column 2
                    CASE row IS
                        WHEN "0111" => aux <= "00010"; --2
                        WHEN "1011" => aux <= "00101"; --5
                        WHEN "1101" => aux <= "01000"; --8
                        WHEN "1110" => aux <= "01111"; --F
                        WHEN OTHERS => aux <= "10000"; -- invalid
                    END CASE;
                WHEN "1101" => --Column 3
                    CASE row IS
                        WHEN "0111" => aux <= "00011"; --3
                        WHEN "1011" => aux <= "00110"; --6
                        WHEN "1101" => aux <= "01001"; --9
                        WHEN "1110" => aux <= "01110"; --E
                        WHEN OTHERS => aux <= "10000"; -- invalid
                    END CASE;
                WHEN "1110" => --Column 4
                    CASE row IS
                        WHEN "0111" => aux <= "01010"; --A
                        WHEN "1011" => aux <= "01011"; --B
                        WHEN "1101" => aux <= "01100"; --C
                        WHEN "1110" => aux <= "01101"; --D
                        WHEN OTHERS => aux <= "10000"; -- invalid
                    END CASE;
                WHEN OTHERS => aux <= "10000"; -- invalid
            END CASE;

        END IF;

        IF clock'event AND clock = '0' THEN
            -- rotate rows
            sclk <= sclk(2 DOWNTO 0) & sclk(3);

            -- another way of achieving the same result using a function instead
            -- sclk <= std_logic_vector(rotate_left(unsigned(sclk), 1));
        END IF;

    END PROCESS;
END Behavioral;
