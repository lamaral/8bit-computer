----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2019 11:47:14 PM
-- Design Name: 
-- Module Name: mar - Behavioral
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

entity mar is
    Port ( BU   : in STD_LOGIC_VECTOR (3 downto 0);
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC;
           MI_L : in STD_LOGIC;
           ADDR : out STD_LOGIC_VECTOR (3 downto 0));
end mar;

architecture Structural of mar is

component register4bit
Port ( CLR : in STD_LOGIC;
       CLK : in STD_LOGIC;
       E_L : in STD_LOGIC;
       D   : in STD_LOGIC_VECTOR (3 downto 0);
       Q   : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin

    U34: register4bit port map(D=>BU, Q=>ADDR, CLR=>CLR, CLK=>CLK, E_L=>MI_L);

end Structural;
