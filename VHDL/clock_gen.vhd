----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2019 11:12:46 PM
-- Design Name: 
-- Module Name: clock_gen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_gen is
    Port ( CLK_IN : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC);
end clock_gen;

architecture Behavioral of clock_gen is

constant C_reload_value : unsigned(31 downto 0) := to_unsigned( 5000000 - 2, 32);
signal counter : unsigned(31 downto 0) := C_reload_value;
signal clk_slow: STD_LOGIC;
signal pulsing: STD_LOGIC := '0';

begin
process(CLK_IN)
begin
    if rising_edge(CLK_IN) then
        if counter(31)='1' then
            counter <= C_reload_value;
            clk_slow <= not clk_slow;
        else
            counter <= counter - 1;
        end if;
    end if;
end process;
CLK_OUT <= clk_slow;
end Behavioral;
