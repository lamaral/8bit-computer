----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2019 10:34:54 PM
-- Design Name: 
-- Module Name: sevenseg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity sevenseg is
    Port ( HS_CLK : in STD_LOGIC;
           HEX1 : in STD_LOGIC_VECTOR (7 downto 0);
           HEX2 : in STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (7 downto 0));
end sevenseg;

architecture Behavioral of sevenseg is

-- Clock de 100MHz. Período é 10E-8s. Refresh rate dos displays é de 2.5E-3s.
-- Como são quatro displays, o valor de 1 milhão dá exatamente 10E-3s.
constant C_reload_value : unsigned(19 downto 0) := to_unsigned( 1000000, 20);
signal counter : STD_LOGIC_VECTOR(19 downto 0);

signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal led_activate: STD_LOGIC_VECTOR(1 downto 0); 

begin
-- Esse processo converte o valor de LED_BCD pra 7seg  
process(LED_BCD)
begin
    case LED_BCD is
        when "0000" => seg <= "00000011"; -- "0"     
        when "0001" => seg <= "10011111"; -- "1" 
        when "0010" => seg <= "00100101"; -- "2" 
        when "0011" => seg <= "00001101"; -- "3" 
        when "0100" => seg <= "10011001"; -- "4" 
        when "0101" => seg <= "01001001"; -- "5" 
        when "0110" => seg <= "01000001"; -- "6" 
        when "0111" => seg <= "00011111"; -- "7" 
        when "1000" => seg <= "00000001"; -- "8"     
        when "1001" => seg <= "00001001"; -- "9" 
        when "1010" => seg <= "00010001"; -- a
        when "1011" => seg <= "11000001"; -- b
        when "1100" => seg <= "01100011"; -- C
        when "1101" => seg <= "10000101"; -- d
        when "1110" => seg <= "01100001"; -- E
        when "1111" => seg <= "01110001"; -- F
    end case;
end process;

-- Esse processo conta para gerar o clock
process(HS_CLK)
begin 
    if(rising_edge(HS_CLK)) then
        if counter>=x"F4240" then
            counter <= (others => '0');
        else
            counter <= counter + 1;
        end if;
    end if;
end process;
led_activate <= counter(19 downto 18);

-- Esse processo faz a multiplexação para os displays 7-seg
process(led_activate)
begin
    case led_activate is
    when "00" =>
        an <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        LED_BCD <= HEX2(7 downto 4);
        -- the first hex digit of the 16-bit number
    when "01" =>
        an <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        LED_BCD <= HEX2(3 downto 0);
        -- the second hex digit of the 16-bit number
    when "10" =>
        an <= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        LED_BCD <= HEX1(7 downto 4);
        -- the third hex digit of the 16-bit number
    when "11" =>
        an <= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        LED_BCD <= HEX1(3 downto 0);
        -- the fourth hex digit of the 16-bit number    
    end case;
end process;
end Behavioral;
