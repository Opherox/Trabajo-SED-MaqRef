library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Visualizador is
Port (
    clk : in std_logic;
    Reset : in std_logic;
    Secuencia_Segm : in integer_vector (7 downto 0);  
    Segm : out std_logic_vector (6 downto 0);
    DigSel : out std_logic_vector (7 downto 0)
    );
end Visualizador;

architecture Behavioral of Visualizador is

signal clk_o : std_logic := '0'; 
signal DigSel_S : std_logic_vector (7 downto 0);
signal DisplayNum : integer := 0;

component Timer is
Port(
    Divider : in integer := 2000000;
    clk : in std_logic;
    Reset : in std_logic; 
    clk_o : out std_logic 
    );
end component Timer;

component gen_secuencias is
Generic(N:Positive:=8);
Port(
    CE: in std_logic;
    clk: in std_logic;
    RESET: in std_logic;
    SEL: out std_logic_vector(N-1 downto 0)
    );
end component gen_secuencias;

component MUX is 
Port(
    input_integer_vector: in integer_vector(7 downto 0);
    SEL: in std_logic_vector(7 downto 0);
    output_integer: out integer
  );
end component MUX;

component Decodificador is
Port(   
    Numero : in integer;
    Segmentos : out std_logic_vector (6 downto 0)
    );
end component Decodificador;
    
begin

    T_I : Timer
    port map(
        Divider => 2000000,
        clk => clk,
        Reset => Reset,
        clk_o => clk_o
        );
    GS_I : gen_secuencias
    port map(
        CE => clk_o,
        clk => clk,
        RESET => Reset,
        SEL => DigSel_S
        );
    MUX_I: MUX
    port map(
        input_integer_vector => Secuencia_Segm,
        SEL => DigSel_S,
        output_integer => DisplayNum
        );
    D_I : Decodificador
    port map(
        Numero => DisplayNum,
        Segmentos => Segm
        );
        
end architecture;
