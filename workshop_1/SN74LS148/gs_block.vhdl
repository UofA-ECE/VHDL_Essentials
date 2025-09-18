LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY gs_block IS
    -- declarative part
    PORT (
        D  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        EI : IN STD_LOGIC;
        EO : OUT STD_LOGIC;
        GS : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Behavioral OF gs_block IS
    -- declarative part
    SIGNAL not_ei : STD_LOGIC := '0';
    SIGNAL eo_s   : STD_LOGIC;
BEGIN
    --statements part
    eo_s   <= NOT(D(0) AND D(1) AND D(2) AND D(3) AND D(4) AND D(5) AND D(6) AND D(7) AND EI);
    eo     <= eo_s;
    not_ei <= NOT EI;
    GS     <= not_ei NAND eo_s;
END Behavioral;
