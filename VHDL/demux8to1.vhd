----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2019 11:50:05 PM
-- Design Name: 
-- Module Name: demux8to1 - Behavioral
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

entity demux8to1 is
    Port ( A   : in  STD_LOGIC_VECTOR (2 downto 0);     -- select input
           O   : out STD_LOGIC_VECTOR (7 downto 0)     -- outputs
          );                        
end demux8to1;

architecture Behavioral of demux8to1 is
begin
    process (A)
    begin
        case A is
            when "000" =>
                O <= "11111110";
            when "001" =>
                O <= "11111101";
            when "010" =>
                O <= "11111011";
            when "011" =>
                O <= "11110111";
            when "100" =>
                O <= "11101111";    
            when "101" =>
                O <= "11011111";
            when "110" =>
                O <= "10111111";
            when "111" =>
                O <= "01111111";
            when others =>
                O <= "11111111";
        end case;
    end process;
end Behavioral;
