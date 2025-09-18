LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
ENTITY input_block IS
    PORT (
        d  : IN STD_LOGIC_VECTOR(1 TO 7);
        ei : IN STD_LOGIC;
        x  : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE Behavioral OF input_block IS
BEGIN
    x(0)  <= NOT d(1);
    X(1)  <= D(2);
    x(2)  <= NOT d(2);
    x(3)  <= NOT d(3);
    x(4)  <= d(4);
    x(5)  <= NOT d(4);
    x(6)  <= d(5);
    x(7)  <= NOT d(5);
    x(8)  <= d(6);
    x(9)  <= NOT d(6);
    x(10) <= NOT d(7);
    x(11) <= NOT EI;
END Behavioral;
