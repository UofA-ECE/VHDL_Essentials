LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY input_block IS
    PORT (
        D  : IN STD_LOGIC_VECTOR(7 DOWNTO 1);
        EI : IN STD_LOGIC;
        X  : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF input_block IS
BEGIN
    X(0)  <= NOT D(1);
    X(1)  <= D(2);
    X(2)  <= NOT D(2);
    X(3)  <= NOT D(3);
    X(4)  <= D(4);
    X(5)  <= NOT D(4);
    X(6)  <= D(5);
    X(7)  <= NOT D(5);
    X(8)  <= D(6);
    X(9)  <= NOT D(6);
    X(10) <= NOT D(7);
    X(11) <= NOT EI;
END behavioral;
