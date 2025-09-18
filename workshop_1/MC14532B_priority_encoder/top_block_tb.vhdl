LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY top_block_tb IS
    --port();
END ENTITY;

ARCHITECTURE test OF top_block_tb IS
    SIGNAL D_tb  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL EI_tb : STD_LOGIC;
    SIGNAL Q_tb  : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL GS_tb : STD_LOGIC;
    SIGNAL EO_tb : STD_LOGIC;
BEGIN

    DUT : ENTITY work.top_block(structural) PORT MAP(D => D_tb, EI => EI_tb, Q => Q_tb, GS => GS_tb, EO => EO_tb);

    PROCESS
    BEGIN

        D_tb  <= "11111111";
        EI_tb <= '1';
        WAIT FOR 10 ns;

        D_tb  <= "11111111";
        EI_tb <= '0';
        WAIT FOR 10 ns;

        D_tb  <= "00000000";
        EI_tb <= '0';
        WAIT FOR 10 ns;
        
        D_tb  <= "00000000";
        EI_tb <= '1';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;
END test;
