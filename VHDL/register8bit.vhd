----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2019 11:03:55 PM
-- Design Name: 
-- Module Name: 74LS173 - Behavioral
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

entity register8bit is
    Port ( CLR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           E: in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end register8bit;

architecture Behavioral of register8bit is

begin
    process(CLK, CLR)
    begin
        if CLR='1' then
            Q <= "00000000";
        elsif rising_edge(clk) then
            if E='0' then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
