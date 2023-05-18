----------------------------------------------------------------------------------
-- Filename : stepper_wave_drive.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 18-May-2023
-- Design Name: stepper_wave_drive
-- Description : Simple controller for a stepper motor using wave drive mode
-- Additional Comments: this design allows to control the direction of rotation
-- and the speed is controlled by two clock dividers, this design is a simple
-- implementation to show how a wave drive controller works.
-- Copyright : University of Alberta, 2023
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY stepper_wave_drive IS
    PORT (
        sysclk     : IN STD_LOGIC;
        cw_step    : IN STD_LOGIC;
        ccw_step   : IN STD_LOGIC;
        speed      : IN STD_LOGIC;
        coil_led   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        motor_coil : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        motor_on   : OUT STD_LOGIC);
END stepper_wave_drive;

ARCHITECTURE Behavioral OF stepper_wave_drive IS
    SIGNAL coil_signal                                                : UNSIGNED(3 DOWNTO 0) := "1000";
    SIGNAL clock_signal, clock_signal_100, clock_signal_10, motor_led : STD_LOGIC;
    SIGNAL counter                                                    : INTEGER := 0;
BEGIN
    clock_divider_100 : ENTITY work.clock_divider(Behavioral) GENERIC MAP(freq_out => 100) PORT MAP(clock => sysclk, clock_div => clock_signal_100);
    clock_divider_10  : ENTITY work.clock_divider(Behavioral) GENERIC MAP(freq_out => 10) PORT MAP(clock => sysclk, clock_div => clock_signal_10);

    coil_led   <= STD_LOGIC_VECTOR(coil_signal);
    motor_on   <= motor_led;
    motor_coil <= STD_LOGIC_VECTOR(coil_signal);

    PROCESS (speed)
    BEGIN
        IF speed = '1' THEN
            clock_signal <= clock_signal_10;
        ELSE
            clock_signal <= clock_signal_100;
        END IF;
    END PROCESS;
    PROCESS (clock_signal)
    BEGIN
        IF rising_edge(clock_signal) THEN
            IF cw_step = '1' AND ccw_step = '0' THEN
                coil_signal <= rotate_right(coil_signal, 1);
                motor_led   <= '1';
            ELSIF cw_step = '0' AND ccw_step = '1' THEN
                coil_signal <= rotate_left(coil_signal, 1);
                motor_led   <= '1';
            ELSE
                motor_led <= '0';
            END IF;

        END IF;
    END PROCESS;
END Behavioral;
