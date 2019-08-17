----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/14/2019 11:25:49 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    Port ( BU   : inout STD_LOGIC_VECTOR (7 downto 0);
           A    : in STD_LOGIC_VECTOR (7 downto 0);
           B    : in STD_LOGIC_VECTOR (7 downto 0);
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC;
           FI_L : in STD_LOGIC;
           EO_L : in STD_LOGIC;
           SU   : in STD_LOGIC;
           CF   : out STD_LOGIC;
           ZF   : out STD_LOGIC);
end alu;

architecture Structural of alu is

component register4bit
Port ( CLR : in STD_LOGIC;
       CLK : in STD_LOGIC;
       E_L : in STD_LOGIC;
       D   : in STD_LOGIC_VECTOR (3 downto 0);
       Q   : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component tristate8bit
Port ( E_L : in STD_LOGIC;
       D   : in STD_LOGIC_VECTOR (7 downto 0);
       Q   : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component xor2
Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       F : out STD_LOGIC);
end component;

component and2
Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       F : out STD_LOGIC);
end component;

component nor2
Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       F : out STD_LOGIC);
end component;

component adder8bit
Port ( A  : in STD_LOGIC_VECTOR (8 downto 1);
       B  : in STD_LOGIC_VECTOR (8 downto 1);
       C0 : in STD_LOGIC;
       C8 : out STD_LOGIC;
       S  : out STD_LOGIC_VECTOR (8 downto 1));
end component;

signal U20_to_U19: STD_LOGIC;
signal U16A_to_U20: STD_LOGIC;
signal U16B_to_U20: STD_LOGIC;
signal U16C_to_U20: STD_LOGIC;
signal U16D_to_U20: STD_LOGIC;
signal U18A_to_U21: STD_LOGIC;
signal U18B_to_U21: STD_LOGIC;
signal U18C_to_U21: STD_LOGIC;
signal U18D_to_U21: STD_LOGIC;
signal U23A_to_U23B: STD_LOGIC;
signal U23C_to_U23B: STD_LOGIC;
signal U22A_to_U23A: STD_LOGIC;
signal U22B_to_U23A: STD_LOGIC;
signal U22C_to_U23C: STD_LOGIC;
signal U22D_to_U23C: STD_LOGIC;
signal U23B_to_U19: STD_LOGIC;

signal result: STD_LOGIC_VECTOR (7 downto 0);

signal unused: STD_LOGIC_VECTOR (1 downto 0);
begin
    U16C: xor2 port map(A=>SU, B=>B(7), F=>U16C_to_U20);
    U16D: xor2 port map(A=>SU, B=>B(6), F=>U16D_to_U20);
    U16A: xor2 port map(A=>SU, B=>B(5), F=>U16A_to_U20);
    U16B: xor2 port map(A=>SU, B=>B(4), F=>U16B_to_U20);
    U18C: xor2 port map(A=>SU, B=>B(3), F=>U18C_to_U21);
    U18D: xor2 port map(A=>SU, B=>B(2), F=>U18D_to_U21);
    U18A: xor2 port map(A=>SU, B=>B(1), F=>U18A_to_U21);
    U18B: xor2 port map(A=>SU, B=>B(0), F=>U18B_to_U21);
    U23A: and2 port map(A=>U22A_to_U23A, B=>U22B_to_U23A, F=>U23A_to_U23B);
    U23C: and2 port map(A=>U22C_to_U23C, B=>U22D_to_U23C, F=>U23C_to_U23B);
    U23B: and2 port map(A=>U23A_to_U23B, B=>U23C_to_U23B, F=>U23B_to_U19);
    U22A: nor2 port map(A=>result(7), B=>result(6), F=>U22A_to_U23A);
    U22B: nor2 port map(A=>result(5), B=>result(4), F=>U22B_to_U23A);
    U22C: nor2 port map(A=>result(3), B=>result(2), F=>U22C_to_U23C);
    U22D: nor2 port map(A=>result(1), B=>result(0), F=>U22D_to_U23C);
    U20U21: adder8bit port map(
        A=>A,
        B(1)=>U18B_to_U21,
        B(2)=>U18A_to_U21,
        B(3)=>U18D_to_U21,
        B(4)=>U18C_to_U21,
        B(5)=>U16B_to_U20,
        B(6)=>U16A_to_U20,
        B(7)=>U16D_to_U20,
        B(8)=>U16C_to_U20,
        C0=>SU,
        C8=>U20_to_U19,
        S=>result
    );
    U17: tristate8bit port map(
        E_L => EO_L, 
        D   => result, 
        Q   => BU
    );
    U19: register4bit port map(
        CLR => CLR, 
        CLK => CLK, 
        E_L => FI_L, 
        D(3 downto 2) => "00", 
        D(0) => U20_to_U19, 
        D(1) => U23B_to_U19,
        Q(0) => CF, 
        Q(1) => ZF,
        Q(3 downto 2) => unused
    );

end Structural;
