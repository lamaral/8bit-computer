----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2019 09:44:17 PM
-- Design Name: 
-- Module Name: pc_module - Structural
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

entity pc_module is
    Port ( CLR_L : in STD_LOGIC;
           CLK   : in STD_LOGIC;
           CE    : in STD_LOGIC;
           CO_L  : in STD_LOGIC;
           J_L   : in STD_LOGIC;
           BU    : inout STD_LOGIC_VECTOR (3 downto 0));
end pc_module;

architecture Structural of pc_module is

component tristate4bit
    Port ( E : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0)
          );
end component;

component bincounter4bit
    Port ( P      : in STD_LOGIC_VECTOR (3 downto 0);
           LOAD_L : in STD_LOGIC;
           CLK    : in STD_LOGIC;
           CLR_L  : in STD_LOGIC;
           EN     : in STD_LOGIC;
           Q      : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal U35_to_U36: STD_LOGIC_VECTOR (3 downto 0);

begin
    U35: bincounter4bit port map(
        P      => BU,
        LOAD_L => J_L,
        CLK    => CLK,
        CLR_L  => CLR_L,
        EN     => CE,
        Q      => U35_to_U36 
    );
    U36: tristate4bit port map(
        D => U35_to_U36,
        Q => BU,
        E => CO_L
    );
end Structural;
