----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2019 11:48:42 PM
-- Design Name: 
-- Module Name: tristate8bit - Behavioral
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

entity tristate8bit is
    Port ( E_L : in STD_LOGIC;
           D   : in STD_LOGIC_VECTOR (7 downto 0);
           Q   : out STD_LOGIC_VECTOR (7 downto 0)
          );
end tristate8bit;

architecture Behavioral of tristate8bit is
begin

    Q <= D when (E_L = '0') else "ZZZZZZZZ";

end Behavioral;
