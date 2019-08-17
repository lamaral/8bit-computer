----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2019 11:03:55 PM
-- Design Name: 
-- Module Name: register4bit - Behavioral
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

entity register4bit is
    Port ( CLR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           E_L : in STD_LOGIC;
           D   : in STD_LOGIC_VECTOR (3 downto 0);
           Q   : out STD_LOGIC_VECTOR (3 downto 0));
end register4bit;

architecture Behavioral of register4bit is

begin
    process(CLK, CLR)
    begin
        if CLR='1' then
            Q <= "0000";
        elsif rising_edge(clk) then
            if E_L='0' then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
