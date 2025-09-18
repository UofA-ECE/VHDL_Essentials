LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY gs_block IS
    -- declarative part GENERICS
    PORT (
        D  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        EI : IN STD_LOGIC;
        GS : OUT STD_LOGIC;
        EO : OUT STD_LOGIC
    );
END ENTITY;
ARCHITECTURE behavioral OF gs_block IS
    -- declarative part
    SIGNAL nor_out  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL nand_out : STD_LOGIC;
BEGIN
    -- statements part
    nor_out(0) <= D(0) NOR D(1);
    nor_out(1) <= D(2) NOR D(3);
    nor_out(2) <= D(4) NOR D(5);
    nor_out(3) <= D(6) NOR D(7);
    nand_out   <= NOT (nor_out(0) AND nor_out(1) AND nor_out(2) AND nor_out(3));
    EO         <= NOT (nor_out(0) AND nor_out(1) AND nor_out(2) AND nor_out(3) AND EI);
    GS         <= EI AND nand_out;
END behavioral;
