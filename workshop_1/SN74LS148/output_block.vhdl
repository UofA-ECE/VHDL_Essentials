LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
ENTITY output_block IS
    PORT (
        y : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF output_block IS
BEGIN
    A(0) <= NOT (Y(0) OR Y(1) OR Y(2) OR Y(3));
    A(1) <= NOT (Y(4) OR Y(5) OR Y(6) OR Y(7));
    A(2) <= NOT (Y(8) OR Y(9) OR Y(10) OR Y(11));
END Behavioral;
