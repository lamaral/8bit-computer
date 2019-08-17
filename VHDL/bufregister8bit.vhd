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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bufregister8bit is
    Port ( BU   : inout STD_LOGIC_VECTOR (7 downto 0);
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC;
           IE_L : in STD_LOGIC;
           OE_L : in STD_LOGIC;
           Q    : out STD_LOGIC_VECTOR (7 downto 0));
end bufregister8bit;

architecture Structural of bufregister8bit is

component register8bit
Port ( CLR : in STD_LOGIC;
       CLK : in STD_LOGIC;
       E   : in STD_LOGIC;
       D   : in STD_LOGIC_VECTOR (7 downto 0);
       Q   : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component tristate8bit
Port ( E_L : in STD_LOGIC;
       D   : in STD_LOGIC_VECTOR (7 downto 0);
       Q   : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal reg1_to_tri1: STD_LOGIC_VECTOR (7 downto 0);

begin
    reg1: register8bit port map(CLR=>CLR, CLK=>CLK, E=>IE_L, D=>BU, Q=>reg1_to_tri1);
    tri1: tristate8bit port map(E_L=>OE_L, D=>reg1_to_tri1, Q=>BU);
    Q <= reg1_to_tri1;
end Structural;
