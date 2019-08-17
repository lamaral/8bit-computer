----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/20/2019 07:15:50 PM
-- Design Name: 
-- Module Name: clock_module - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_module is
    Port ( HLT    : in STD_LOGIC;
           HS_CLK : in STD_LOGIC;
           P_BTN  : in STD_LOGIC;
           SEL    : in STD_LOGIC;
           CLK    : out STD_LOGIC;
           CLK_L  : out STD_LOGIC);
end clock_module;

architecture Structural of clock_module is

component and2
Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       F : out STD_LOGIC);
end component;

component clock_gen
    Port ( CLK_IN : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC);
end component;

component or2
Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       F : out STD_LOGIC);
end component;

signal CLK_OUT: STD_LOGIC;
signal U5A_to_U6A: STD_LOGIC;
signal U5B_to_U6A: STD_LOGIC;
signal U6A_to_U5C: STD_LOGIC;
signal U5C_OUT: STD_LOGIC;
signal SEL_L: STD_LOGIC;
signal HLT_L: STD_LOGIC;

begin

    gen1: clock_gen port map(
        CLK_IN  => HS_CLK,
        CLK_OUT => CLK_OUT 
    );
    
    U5A: and2 port map(
        A => CLK_OUT,
        B => SEL,
        F => U5A_to_U6A
    );
    
    U5B: and2 port map(
        A => P_BTN,
        B => SEL_L,
        F => U5B_to_U6A
    );
    
    U5C: and2 port map(
        A => U6A_to_U5C,
        B => HLT_L,
        F => U5C_OUT
    );
    
    U6A: or2 port map(
        A => U5A_to_U6A,
        B => U5B_to_U6A,
        F => U6A_to_U5C 
    );
    
    SEL_L <= NOT SEL;
    HLT_L <= NOT HLT;
    CLK   <= U5C_OUT;
    CLK_L <= NOT U5C_OUT;
end Structural;
