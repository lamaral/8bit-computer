----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2019 09:44:17 PM
-- Design Name: 
-- Module Name: control_module - Structural
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

entity control_module is
    Port ( CF    : in STD_LOGIC;
           CLK_L : in STD_LOGIC;
           HS_CLK: in STD_LOGIC;
           RST   : in STD_LOGIC;
           ZF    : in STD_LOGIC;
           AI_L  : out STD_LOGIC;
           AO_L  : out STD_LOGIC;
           BI_L  : out STD_LOGIC;
           CE    : out STD_LOGIC;
           CLR   : out STD_LOGIC;
           CLR_L : out STD_LOGIC;
           CO_L  : out STD_LOGIC;
           EO_L  : out STD_LOGIC;
           FI_L  : out STD_LOGIC;
           HLT   : out STD_LOGIC;
           IO_L  : out STD_LOGIC;
           II_L  : out STD_LOGIC;
           J_L   : out STD_LOGIC;
           MI_L  : out STD_LOGIC;
           RI    : out STD_LOGIC;
           RO_L  : out STD_LOGIC;
           SU    : out STD_LOGIC;
           OI    : out STD_LOGIC;
           IR    : in STD_LOGIC_VECTOR (7 downto 4));
end control_module;

architecture Structural of control_module is

component bincounter4bit
    Port ( P      : in STD_LOGIC_VECTOR (3 downto 0);
           LOAD_L : in STD_LOGIC;
           CLK    : in STD_LOGIC;
           CLR_L  : in STD_LOGIC;
           EN     : in STD_LOGIC;
           Q      : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component control_rom
    Port ( CLKA  : in STD_LOGIC;
           ADDRA : in STD_LOGIC_VECTOR(8 DOWNTO 0);
           DOUTA : out STD_LOGIC_VECTOR(15 DOWNTO 0)
          );
end component;

component demux8to1
    Port ( A   : in  STD_LOGIC_VECTOR (2 downto 0);
           O   : out STD_LOGIC_VECTOR (7 downto 0)  
          );                        
end component;

signal U50_to_U48 : STD_LOGIC_VECTOR (7 downto 0);
signal ADDR       : STD_LOGIC_VECTOR (8 downto 0);
signal DOUT       : STD_LOGIC_VECTOR (15 downto 0);
signal U48_MR_L   : STD_LOGIC;
signal whatever   : STD_LOGIC;

begin
    U48: bincounter4bit port map(
        P             => "0000",
        LOAD_L        => '1',
        CLK           => CLK_L,
        CLR_L         => U48_MR_L,
        EN            => '1',
        Q(3)          => whatever,
        Q(2 downto 0) => ADDR(2 downto 0)
    );
    U50: demux8to1 port map(
        A => ADDR(2 downto 0),
        O => U50_to_U48
    );
    U47_U52 : control_rom port map(
        CLKA  => HS_CLK,
        ADDRA => ADDR,
        DOUTA => DOUT
    );
    
    FI_L <= not DOUT(0);
    J_L  <= not DOUT(1);
    CO_L <= not DOUT(2);
    CE   <= DOUT(3);
    OI   <= DOUT(4);
    BI_L <= not DOUT(5);
    SU   <= DOUT(6);
    EO_L <= not DOUT(7);
    AO_L <= not DOUT(8);
    AI_L <= not DOUT(9);
    II_L <= not DOUT(10);
    IO_L <= not DOUT(11);
    RO_L <= not DOUT(12);
    RI   <= DOUT(13);
    MI_L <= not DOUT(14);
    HLT  <= DOUT(15);
    
    ADDR(8) <= ZF;
    ADDR(7) <= CF;
    ADDR(6 downto 3) <= IR;
    U48_MR_L <= U50_to_U48(5) and not RST;
    CLR      <= RST;
    CLR_L    <= not RST;
end Structural;
