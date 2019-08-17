----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2019 08:22:36 PM
-- Design Name: 
-- Module Name: adder8bit - Behavioral
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

entity adder8bit is
    Port ( A : in STD_LOGIC_VECTOR (8 downto 1);
           B : in STD_LOGIC_VECTOR (8 downto 1);
           C0 : in STD_LOGIC;
           C8 : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (8 downto 1));
end adder8bit;


architecture Structural of adder8bit is


-- Full Adder VHDL Code Component Decalaration
component fulladder
Port ( A : in STD_LOGIC;
B : in STD_LOGIC;
Cin : in STD_LOGIC;
S : out STD_LOGIC;
Cout : out STD_LOGIC);
end component;

-- Intermediate Carry declaration
signal C1,C2,C3,C4,C5,C6,C7: STD_LOGIC;

begin

-- Port Mapping Full Adder 4 times
FA1: fulladder port map(A=>A(1), B=>B(1), Cin=>C0, S=>S(1), Cout=>C1);
FA2: fulladder port map(A=>A(2), B=>B(2), Cin=>C1, S=>S(2), Cout=>C2);
FA3: fulladder port map(A=>A(3), B=>B(3), Cin=>C2, S=>S(3), Cout=>C3);
FA4: fulladder port map(A=>A(4), B=>B(4), Cin=>C3, S=>S(4), Cout=>C4);
FA5: fulladder port map(A=>A(5), B=>B(5), Cin=>C4, S=>S(5), Cout=>C5);
FA6: fulladder port map(A=>A(6), B=>B(6), Cin=>C5, S=>S(6), Cout=>C6);
FA7: fulladder port map(A=>A(7), B=>B(7), Cin=>C6, S=>S(7), Cout=>C7);
FA8: fulladder port map(A=>A(8), B=>B(8), Cin=>C7, S=>S(8), Cout=>C8);

end Structural;
