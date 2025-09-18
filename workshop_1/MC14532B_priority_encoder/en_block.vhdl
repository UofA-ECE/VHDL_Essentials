LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY en_block IS
    PORT (
        X : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        Y : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF en_block IS
BEGIN
    Y(11) <= X(10) OR X(11);
    Y(10) <= X(10) OR X(11);
    Y(9)  <= X(10) OR X(11);
    Y(8)  <= X(11) OR X(9);
    Y(7)  <= X(11) OR X(9);
    Y(6)  <= X(11) OR X(7);
    Y(5)  <= X(11) OR X(8) OR X(7);
    Y(4)  <= X(11) OR X(5);
    Y(3)  <= X(11) OR X(8) OR X(4) OR X(3);
    Y(2)  <= X(11) OR X(6) OR X(4) OR X(3);
    Y(1)  <= X(11) OR X(6) OR X(4) OR X(2);
    Y(0)  <= X(11) OR X(8) OR X(1) OR X(4) OR X(0);
END behavioral;
