LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY en_block IS
    -- declarative part
    PORT (
        X : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        Y : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF en_block IS
BEGIN
    Y(0)  <= X(0) AND X(1) AND x(4) AND x(8) AND x(11);
    Y(1)  <= X(3) AND X(4) AND x(8) AND x(11);
    Y(2)  <= X(7) AND x(8) AND x(11);
    y(3)  <= x(10) AND x(11);
    y(4)  <= X(2) AND X(4) AND x(6) AND x(11);
    y(5)  <= X(3) AND X(4) AND x(6) AND x(11);
    y(6)  <= x(9) AND x(11);
    y(7)  <= x(10) AND x(11);
    y(8)  <= x(5) AND x(11);
    y(9)  <= x(7) AND x(11);
    y(10) <= x(9) AND x(11);
    y(11) <= x(10) AND x(11);
END behavioral;
