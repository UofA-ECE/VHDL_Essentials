LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY output_block IS
    PORT (
        Y : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF output_block IS
BEGIN
    Q(0) <= NOT (Y(0) AND Y(3) AND Y(5) AND Y(8));
    Q(1) <= NOT (Y(1) AND Y(2) AND Y(7) AND Y(9));
    Q(2) <= NOT (Y(4) AND Y(6) AND Y(10) AND Y(11));
END behavioral;
