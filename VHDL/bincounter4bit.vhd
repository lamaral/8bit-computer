----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2019 09:06:25 PM
-- Design Name: 
-- Module Name: bincounter4bit - Behavioral
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

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bincounter4bit is
    Port ( P      : in STD_LOGIC_VECTOR (3 downto 0);
           LOAD_L : in STD_LOGIC;
           CLK    : in STD_LOGIC;
           CLR_L  : in STD_LOGIC;
           EN     : in STD_LOGIC;
           Q      : out STD_LOGIC_VECTOR (3 downto 0));
end bincounter4bit;

architecture Behavioral of bincounter4bit is
signal COUNT: STD_LOGIC_VECTOR (3 downto 0);
begin
    process(CLK,CLR_L)
    begin
        if CLR_L='0' then
            COUNT <= "0000";
        elsif rising_edge(clk) then
            if EN='1' and LOAD_L='1' then
                COUNT <= COUNT + 1;
            elsif LOAD_L='0' then
                COUNT <= P;
            end if;
        end if;
    end process;
    Q <= COUNT;
end Behavioral;
