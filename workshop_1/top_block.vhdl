LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY top_block IS
    PORT (
        D  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        EI : IN STD_LOGIC;
        Q  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        GS : OUT STD_LOGIC;
        EO : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE structural OF top_block IS
    SIGNAL X_S : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL E_S : STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
    i_block      : ENTITY WORK.input_block(behavioral) PORT MAP(D => D(7 DOWNTO 1), EI => EI, X => X_S);
    e_block      : ENTITY WORK.en_block(behavioral) PORT MAP(X => X_S, Y => E_S);
    group_select : ENTITY WORK.gs_block(behavioral) PORT MAP(D => D, EI => EI, GS => GS, EO => EO);
    o_block      : ENTITY WORK.output_block(behavioral) PORT MAP(Y => E_S, Q => Q);
END structural;
