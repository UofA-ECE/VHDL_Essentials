----------------------------------------------------------------------------------
-- Filename : essentials_1.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 25-Oct-10-2022
-- Design Name: entity_declaration
-- Module Name: black_box
-- Project Name: VHDL_essentials
-- Description : In this file we go over the process of declaring an entity in different ways using VHDL
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------


-- **************************************************************************** --
-- **************************** IMPORTANT ************************************* --
-- **************************************************************************** --
-- *                                                                          * --
-- *            This file is not valid VHDL code on it's own,                 * --
-- *                    it's only meant as an example for                     * --
-- *                        the entity declaration                            * --
-- *                                                                          * --
-- **************************************************************************** --
-- **************************** IMPORTANT ************************************* --
-- **************************************************************************** --


-- The top level of every design hierarchy must be an entity.
-- Entities may range from primitive circuits to complex assemblies.
-- The entity describes the interface to the outside world (describes the I/O ports of an electronic circuit). It specifies the number,
-- the direction, and the type of the ports.
-- A port can be an input port, or an output port, or both input and output port at the same time, or it can be a buffer port.
-- general structure of entity unit.
ENTITY entity_name IS
    GENERIC (generic_variable_declarations); -- optional
    PORT (
        port_ID1 : I/O option signal_type; -- port_ID1 represents the name of the port I/O option refers to the port type (I, O, I/O, Buffer)
        port_ID2 : I/O option signal_type; -- signal type refers to the data type of the port (std_logic, std_logic_vector, integer, bit, etc.)
    );
    [ declarations ] -- optional
BEGIN -- optional
    [ statements ] -- optional  
END [ENTITY] [entity_name]; -- the words inside the brackets are optional but are encouraged since it makes the code more readable


-- Excercise 1:
-- Write the VHDL code for the entity declaration of the black box circuit shown below:
--          -------
--         |       |---- Out0
-- A ------| black |---- Out1
-- B ------|  box  |---- Out2
--         |       |
--          -------

ENTITY black_box IS
    PORT (
        -- Input Ports
        A, B : IN STD_LOGIC;
        -- Output ports
        Out0, Out1, Out2 : OUT STD_LOGIC -- the contents of the port declaration are meant to be written as a list, so as a rule
        -- the last port declaration must NOT include the semicolon ';' at the end of the line
    );
END;

-- We can rewrite the architecture like this
ENTITY black_box IS
    PORT (
        -- Input ports can be declared individually for improved readability
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        -- We can do the same for the output ports
        Out0 : OUT STD_LOGIC;
        Out1 : OUT STD_LOGIC;
        Out2 : OUT STD_LOGIC
    );
END black_box; -- end of ENTITY
-- Excercise 2:
-- Write the VHDL code for the entity declaration of the black box circuit shown below:
--          -------    5
--      5  |       |--/-- Out0
-- I0 --/--| black |----- Out1
-- I1 --/--|  box  |----- Out2
--     3   |       |
--          -------

-- This time we will use the std_logic_vector type to define some of the ports
ENTITY black_box IS
    PORT (
        -- input ports
        I0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        I1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- output ports
        Out0 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        Out1 : OUT STD_LOGIC;
        Out2 : OUT STD_LOGIC
    );
END black_box; -- END of ENTITY

-- As an excercise we will now do the same declaration using std_logic, so we need to split the bus into individual bits
ENTITY black_box IS
    PORT (
        -- input ports
        I0_0 : IN STD_LOGIC;
        I0_1 : IN STD_LOGIC;
        I0_2 : IN STD_LOGIC;
        I0_3 : IN STD_LOGIC;
        I0_4 : IN STD_LOGIC;
        I1_0 : IN STD_LOGIC;
        I1_1 : IN STD_LOGIC;
        I1_2 : IN STD_LOGIC;
        -- output ports
        Out0_0 : OUT STD_LOGIC;
        Out0_1 : OUT STD_LOGIC;
        Out0_2 : OUT STD_LOGIC;
        Out0_3 : OUT STD_LOGIC;
        Out0_4 : OUT STD_LOGIC;
        Out1 : OUT STD_LOGIC;
        Out2 : OUT STD_LOGIC
    );
END black_box; -- END of ENTITY
