LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY priority_encoder IS
    PORT (
        Din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        EI  : IN STD_LOGIC;
        A   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        EO  : OUT STD_LOGIC;
        GS  : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE structural OF priority_encoder IS
    SIGNAL enable_in  : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL enable_out : STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
    i_block      : ENTITY WORK.input_block(Behavioral) PORT MAP(d => Din(7 DOWNTO 1), ei => ei, x => enable_in);
    e_block      : ENTITY WORK.en_block(Behavioral) PORT MAP(x => enable_in, y => enable_out);
    o_block      : ENTITY work.output_block(Behavioral) PORT MAP(y => enable_out, A => A);
    group_select : ENTITY work.gs_block(Behavioral) PORT MAP(D => Din, EI => EI, EO => EO, GS => GS);
END structural;
