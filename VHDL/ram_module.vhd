----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2019 11:53:34 PM
-- Design Name: 
-- Module Name: ram_module - Behavioral
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

entity ram_module is
    Port ( BU     : inout STD_LOGIC_VECTOR (7 downto 0);
           ADDR   : in STD_LOGIC_VECTOR (3 downto 0);
           CLK    : in STD_LOGIC;
           HS_CLK : in STD_LOGIC;
           RI     : in STD_LOGIC;
           RO_L   : in STD_LOGIC
           );
end ram_module;

architecture Structural of ram_module is

component and2
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           F : out STD_LOGIC);
end component;

component tristate8bit
    Port ( E_L : in STD_LOGIC;
           D   : in STD_LOGIC_VECTOR (7 downto 0);
           Q   : out STD_LOGIC_VECTOR (7 downto 0)
          );
end component;

component ram_memory
    port (
        clka  : in STD_LOGIC;
        wea   : in STD_LOGIC;
        addra : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        dina  : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        clkb  : in STD_LOGIC;
        addrb : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        doutb : out STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end component;

signal WE: STD_LOGIC;
signal RAM1_to_U30: STD_LOGIC_VECTOR(7 downto 0);

begin

    U31A: and2 port map(
        A => RI,
        B => CLK, 
        F => WE
    );
    U30: tristate8bit port map(
        E_L => RO_L,
        D   => RAM1_to_U30,
        Q   => BU
    );
    RAM1 : ram_memory port map(
        clka  => HS_CLK,
        wea   => WE,
        addra => ADDR,
        dina  => BU,
        clkb  => HS_CLK,
        addrb => ADDR,
        doutb => RAM1_to_U30
    );

end Structural;
