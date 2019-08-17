----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2019 11:48:42 PM
-- Design Name: 
-- Module Name: topmodule - Behavioral
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

entity topmodule is
    Port ( HS_CLK: in  STD_LOGIC;
           btn   : in  STD_LOGIC_VECTOR(4 downto 0);
           D     : in  STD_LOGIC_VECTOR(15 downto 0);
           Q     : out STD_LOGIC_VECTOR(15 downto 0);
           an    : out STD_LOGIC_VECTOR(3 downto 0);
           seg   : out STD_LOGIC_VECTOR(7 downto 0);
           JA    : out STD_LOGIC_VECTOR(1 downto 0)
          );
           
end topmodule;

architecture Structural of topmodule is

component alu
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
end component;

component and2
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           F : out STD_LOGIC);
end component;

component bufregister8bit
    Port ( BU   : inout STD_LOGIC_VECTOR (7 downto 0);
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC;
           IE_L : in STD_LOGIC;
           OE_L : in STD_LOGIC;
           Q    : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component clock_module
    Port ( HLT    : in STD_LOGIC;
           HS_CLK : in STD_LOGIC;
           P_BTN  : in STD_LOGIC;
           SEL    : in STD_LOGIC;
           CLK    : out STD_LOGIC;
           CLK_L  : out STD_LOGIC);
end component;

component control_module
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
end component;

component debouncer5bit
    Port ( SIGNAL_I : in  STD_LOGIC_VECTOR(4 downto 0);
           CLK_I    : in  STD_LOGIC;
           SIGNAL_O : out  STD_LOGIC_VECTOR(4 downto 0));
end component;

component instregister
    Port ( BU   : inout STD_LOGIC_VECTOR (7 downto 0);
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC;
           II_L : in STD_LOGIC;
           IO_L : in STD_LOGIC;
           IR   : out STD_LOGIC_VECTOR (7 downto 4));
end component;

component mar
    Port ( BU   : in STD_LOGIC_VECTOR (3 downto 0);
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC;
           MI_L : in STD_LOGIC;
           ADDR : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component or2
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           F : out STD_LOGIC);
end component;

component pc_module
    Port ( CLR_L : in STD_LOGIC;
           CLK   : in STD_LOGIC;
           CE    : in STD_LOGIC;
           CO_L  : in STD_LOGIC;
           J_L   : in STD_LOGIC;
           BU    : inout STD_LOGIC_VECTOR (3 downto 0));
end component;

component ram_module
    Port ( BU     : inout STD_LOGIC_VECTOR (7 downto 0);
           ADDR   : in STD_LOGIC_VECTOR (3 downto 0);
           CLK    : in STD_LOGIC;
           HS_CLK : in STD_LOGIC;
           RI     : in STD_LOGIC;
           RO_L   : in STD_LOGIC);
end component;

component register8bit
    Port ( CLR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           E: in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component sevenseg
    Port ( HS_CLK : in STD_LOGIC;
           HEX1   : in STD_LOGIC_VECTOR (7 downto 0);
           HEX2   : in STD_LOGIC_VECTOR (7 downto 0);
           an     : out STD_LOGIC_VECTOR (3 downto 0);
           seg    : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- Random additional signals
signal BTNC        : STD_LOGIC;
signal BTNU        : STD_LOGIC;
signal BTNL        : STD_LOGIC;
signal BTNR        : STD_LOGIC;
signal BTND        : STD_LOGIC;
signal U46A_to_U44 : STD_LOGIC;
signal output      : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others=>'0');

-- Signals connecting different circuits in the computer
signal HLT   : STD_LOGIC; -- LED 14 halt
signal CLK   : STD_LOGIC;
signal CLK_L : STD_LOGIC;
signal CLR   : STD_LOGIC;
signal CLR_L : STD_LOGIC; 
signal A     : STD_LOGIC_VECTOR (7 downto 0);
signal ADDR  : STD_LOGIC_VECTOR (3 downto 0);
signal B     : STD_LOGIC_VECTOR (7 downto 0);
signal BU    : STD_LOGIC_VECTOR (7 downto 0);
signal IR    : STD_LOGIC_VECTOR (7 downto 4);
signal AI_L  : STD_LOGIC; -- LED 8  A register in
signal AO_L  : STD_LOGIC; -- LED 7  A register out
signal BI_L  : STD_LOGIC; -- LED 4  B register in
signal CE    : STD_LOGIC; -- LED 2  Counter enable
signal CF    : STD_LOGIC; --  
signal CO_L  : STD_LOGIC; -- LED 1  Counter out
signal EO_L  : STD_LOGIC; -- LED 6  ALU Out
signal FI_L  : STD_LOGIC; -- 
signal II_L  : STD_LOGIC; -- LED 9  inst register in
signal IO_L  : STD_LOGIC; -- LED 10 inst register out
signal J_L   : STD_LOGIC; -- LED 0  Jump
signal MI_L  : STD_LOGIC; -- LED 13 memory MAR in
signal OI    : STD_LOGIC; -- LED 3  Output in
signal RI    : STD_LOGIC; -- LED 12 RAM in
signal RO_L  : STD_LOGIC; -- LED 11 RAM out
signal SU    : STD_LOGIC; -- LED 5  Subtract
signal ZF    : STD_LOGIC;



begin
    dbc1: debouncer5bit port map(
        SIGNAL_I    => btn,
        CLK_I       => HS_CLK,
        SIGNAL_O(0) => BTNC,
        SIGNAL_O(1) => BTNU,
        SIGNAL_O(2) => BTNL,
        SIGNAL_O(3) => BTNR,
        SIGNAL_O(4) => BTND
    );

    gen1: clock_module port map(
        HLT    => HLT,
        HS_CLK => HS_CLK,
        P_BTN  => BTNC,
        SEL    => D(15),
        CLK    => CLK,
        CLK_L  => CLK_L
    );
    
    alu1: alu port map(
        BU    => BU,
        A     => A,
        B     => B,
        CLK   => CLK,
        CLR   => CLR,
        FI_L  => FI_L,
        EO_L  => EO_L,
        SU    => SU,
        CF    => CF,
        ZF    => ZF
    );
    
    a_register: bufregister8bit port map(
        BU   => BU,
        CLK  => CLK,
        CLR  => CLR,
        IE_L => AI_L,
        OE_L => AO_L,
        Q    => A
    );
    
    b_register: bufregister8bit port map(
        BU   => BU,
        CLK  => CLK,
        CLR  => CLR,
        IE_L => BI_L,
        OE_L => '1',
        Q    => B
    );
    
    inst_register: instregister port map(
        BU   => BU,
        CLK  => CLK,
        CLR  => CLR,
        II_L => II_L,
        IO_L => IO_L,
        IR   => IR    
    );
    
    mar1: mar port map(
        BU   => BU(3 downto 0),
        CLK  => CLK,
        CLR  => CLR,
        MI_L => MI_L,
        ADDR => ADDR
    );
    
    program_counter: pc_module port map(
        CLR_L => CLR_L,
        CLK   => CLK,
        CE    => CE,
        CO_L  => CO_L,
        J_L   => J_L,
        BU    => BU(3 downto 0)
    );
    
    ram: ram_module port map(
        BU     => BU,
        ADDR   => ADDR,
        CLK    => CLK,
        HS_CLK => HS_CLK,
        RI     => RI,
        RO_L   => RO_L    
    );
    ctrl: control_module port map(
        CF     => CF,
        CLK_L  => CLK_L,
        HS_CLK => HS_CLK,
        RST    => BTNU,
        ZF     => ZF,
        AI_L   => AI_L,
        AO_L   => AO_L,
        BI_L   => BI_L,
        CE     => CE,
        CLR    => CLR,
        CLR_L  => CLR_L,
        CO_L   => CO_L,
        EO_L   => EO_L,
        FI_L   => FI_L,
        HLT    => HLT,
        IO_L   => IO_L,
        II_L   => II_L,
        J_L    => J_L,
        MI_L   => MI_L,
        RI     => RI,
        RO_L   => RO_L,
        SU     => SU,
        OI     => OI,
        IR     => IR
    );
    
    -- Output viewer section
    U46A: and2 port map(
        A => OI,
        B => CLK,
        F => U46A_to_U44
    );
    
    U44: register8bit port map(
        CLR => CLR,
        CLK => U46A_to_U44,
        E   => '0',
        D   => BU,
        Q   => output
    );
    
    seg1: sevenseg port map(
        HS_CLK => HS_CLK,
        HEX1   => output,
        HEX2   => BU,
        an     => an,
        seg    => seg
    );
    
    
    -- Assign the control signals to the LEDs for debugging 
    Q(15) <= HLT;
    Q(14) <= not MI_L;
    Q(13) <= RI;
    Q(12) <= not RO_L;
    Q(11) <= not IO_L;
    Q(10) <= not II_L;
    Q(9) <= not AI_L;
    Q(8) <= not AO_L;
    Q(7) <= not EO_L;
    Q(6) <= SU;
    Q(5) <= not BI_L;
    Q(4) <= OI;
--    Q(3) <= CE;
--    Q(2) <= not CO_L;
    Q(3) <= ZF;
    Q(2) <= CF;
    Q(1) <= not J_L;
    Q(0) <= not FI_L;
    
    -- Assign control signals to the switches
    -- Uncoment this to run the computer based 
    -- on switch inputs instead of control logic
--    J_L  <= not D(0);
--    CO_L <= not D(1);
--    CE   <= D(2);
--    OI   <= D(3);
--    BI_L <= not D(4);
--    SU   <= D(5);
--    EO_L <= not D(6);
--    AO_L <= not D(7);
--    AI_L <= not D(8);
--    II_L <= not D(9);
--    IO_L <= not D(10);
--    RO_L <= not D(11);
--    RI   <= D(12);
--    MI_L <= not D(13);
--    HLT  <= D(14);
--    CLR  <= D(15);
--    CLR_L<= not D(15);
    
    -- Output on the board pins for debugging
    JA(0) <= CLK;
    JA(1) <= BTNC;
end Structural;
