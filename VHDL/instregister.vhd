----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2019 10:57:19 PM
-- Design Name: 
-- Module Name: bufregister8bit - Behavioral
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

entity instregister is
    Port ( BU   : inout STD_LOGIC_VECTOR (7 downto 0);
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC;
           II_L : in STD_LOGIC;
           IO_L : in STD_LOGIC;
           IR   : out STD_LOGIC_VECTOR (7 downto 4));
end instregister;

architecture Structural of instregister is

component register8bit
Port ( CLR : in STD_LOGIC;
       CLK : in STD_LOGIC;
       E: in STD_LOGIC;
       D : in STD_LOGIC_VECTOR (7 downto 0);
       Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component tristate8bit
Port ( E_L : in STD_LOGIC;
       D   : in STD_LOGIC_VECTOR (7 downto 0);
       Q   : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal reg1_to_tri1: STD_LOGIC_VECTOR (3 downto 0);

begin
    reg1: register8bit port map(CLR=>CLR, CLK=>CLK, E=>II_L, D=>BU, Q(7 downto 4)=>IR, Q(3 downto 0)=>reg1_to_tri1);
    tri1: tristate8bit port map(E_L=>IO_L, D(7 downto 4)=>"0000", D(3 downto 0)=>reg1_to_tri1, Q=>BU);
end Structural;
