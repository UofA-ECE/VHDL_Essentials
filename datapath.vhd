----------------------------------------------------------------------------------
-- Company: University of Alberta
-- Engineer: Bowen Liu
-- 
-- Create Date: 11/23/2022 01:22:04 PM
-- Design Name: 
-- Module Name: datapath - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: datapath for 32 bit RISC-V iinteger instruction set
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- missing signals are added using format "uXX_out"
-- alu's output is changed to alu_out to avoid confusion with the alu component
----------------------------------------------------------------------------------
-- this is a comment

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    Port (
        -- Inputs from Controller
        sub_sra : in std_logic;
        alu_func : in std_logic_vector(2 downto 0);
        addr_sel : in std_logic;
        rd_sel : in std_logic_vector(1 downto 0);
        alu_a_sel, alu_b_sel : in std_logic;
        mem_clk, rd_clk, pc_clk, insn_clk : in std_logic;
        pc_alu_sel, pc_next_sel : in std_logic;
        --sx_size : in std_logic_vector(2 downto 0);
        reset : in std_logic;
        -- I/O from imm_sx, mbr_sx
        imm_x : in std_logic_vector(31 downto 0);
        mem_sx : in std_logic_vector(31 downto 0);
        mem_out : buffer std_logic_vector(31 downto 0);
        -- Outputs to Controller
        EQ : out std_logic;
        A_lt_B : out std_logic;
        A_lt_UB : out std_logic;
        insn : buffer std_logic_vector(31 downto 0)
    );
end datapath;

architecture Behavioral of datapath is

    component register_file is
        port(
            wr : in std_logic;
            wa : in std_logic_vector(4 downto 0);
            wd : in std_logic_vector(31 downto 0);
            reset : in std_logic;
            aa : out std_logic_vector(4 downto 0);
            ad : out std_logic_vector(31 downto 0);
            ba : out std_logic_vector(4 downto 0);
            bd : out std_logic_vector(31 downto 0));
    end component;

    component alu_unit is
        port(
            a, b : in std_logic_vector(31 downto 0);
            func : in std_logic_vector(2 downto 0);
            sub_sra : in std_logic;
            shamt : in std_logic_vector(4 downto 0);
            q : out std_logic_vector(31 downto 0);
            EQ, A_lt_B, A_lt_UB : out std_logic);
    end component;

    component mux2 is
        port(
            i0, i1 : in std_logic_vector(31 downto 0);
            a0 : in std_logic;
            q : out std_logic_vector(31 downto 0));
    end component;

    component mux4 is
        port(
            i0, i1, i2, i3 : in std_logic_vector(31 downto 0);
            a0, a1 : in std_logic;
            q : out std_logic_vector(31 downto 0));
    end component;

    component mem is -- not done
        port(
            rd_addr, wr_addr : in std_logic_vector(31 downto 0);
            we : in std_logic;
            din : in std_logic_vector(31 downto 0);
            dout : out std_logic_vector(31 downto 0));
    end component;

    -- used for PC and INSN
    component d_ff is
        port(
            cp, reset : in std_logic;
            din : in std_logic_vector(31 downto 0);
            dout : out std_logic_vector(31 downto 0));
    end component;

    component adder is
        port(
            a, b : in std_logic_vector(31 downto 0);
            q : out std_logic_vector(31 downto 0));
    end component;

    signal addr, alu_out, rs1_val, rs2_val, pc, rd_val, pc_alu,
 u12_out, u13_out, u14_out, u17_out : std_logic_vector(31 downto 0);

begin

    U11 : register_file port map(
            wr => rd_clk,
            wa => insn(24 downto 20),
            wd => rd_val,
            reset => reset,
            aa => insn(19 downto 15),
            ad => rs1_val,
            ba => insn(24 downto 20),
            bd => rs2_val);
            
    U12 : mux2 port map(
            i0 => imm_x,
            i1 => std_logic_vector(to_signed(4,32)),
            a0 => pc_alu_sel,
            q => u12_out); 

    U13 : mux2 port map(
            i0 => rs1_val,
            i1 => pc,
            a0 => alu_a_sel,
            q => u13_out);

    U14 : mux2 port map(
            i0 => rs2_val,
            i1 => imm_x,
            a0 => alu_b_sel,
            q => u14_out);
    
    U15 : adder port map(
            a => u12_out,
            b => pc, 
            q => pc_alu);
            
    U16 : mux4 port map(
            i0 => pc_alu,
            i1 => alu_out,
            i2 => (others => '0'),
            i3 => mem_sx,
            a0 => rd_sel(0),
            a1 => rd_sel(1),
            q => rd_val);   
    
    U17 : mux2 port map(
            i0 => pc_alu,
            i1 => alu_out,
            a0 => pc_next_sel,
            q => u17_out);  
    
    -- PC
    U18 : d_ff port map(
            cp => pc_clk,
            din => u17_out,
            reset => reset,
            dout => pc);   
          
    U19 : alu_unit port map(
            a => u13_out,
            b => u14_out,
            func => alu_func,
            sub_sra => sub_sra,
            shamt => imm_x(4 downto 0),
            eq => eq,
            A_lt_B => A_lt_B,
            A_lt_UB => A_lt_UB,
            q => alu_out);
     
     -- INSN
     U20 : d_ff port map(
            cp => insn_clk,
            din => mem_out,
            reset => reset,
            dout => insn);   
            
     U21 : mux2 port map(
            i0 => alu_out,
            i1 => pc,
            a0 => addr_sel, 
            q => addr);  
            
     U22 : mem port map(
            rd_addr => addr,
            wr_addr => addr,
            we => mem_clk,
            din => rs2_val,
            dout => mem_out);

end Behavioral;
