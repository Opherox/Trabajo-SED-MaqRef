library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Gestor_Dinero is
    Port(
        cent10 : in std_logic;
        cent20 : in std_logic;
        cent50 : in std_logic;
        cent100 : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        Reset_D : in std_logic;
        precio : in integer;
        falta_dinero : out std_logic;
        sobra_dinero : out std_logic;
        dinero_justo : out std_logic;
        dinero_act : out integer);
end Gestor_Dinero;

architecture Estructural of Gestor_Dinero is
    
    component comparador is
        Port(
        dinero_act : in integer;
        precio : in integer;
        clk : in std_logic;
        reset : in std_logic;
        falta_dinero : out std_logic;
        dinero_justo : out std_logic;
        sobra_dinero : out std_logic);
     end component;
     
     component contador is
        Port(
        cent10 : in std_logic;
        cent20 : in std_logic;
        cent50 : in std_logic;
        cent100 : in std_logic;
        reset : in std_logic;
        clk : in std_logic;
        Reset_D : in std_logic;
        dinero : out integer); 
     end component;
     
    signal dinero_actual:integer; 
begin

 cont: contador
    Port map(
    cent10=>cent10,
    cent20=>cent20,
    cent50=>cent50,
    cent100=>cent100,
    reset=>reset,
    Reset_D => Reset_D, 
    clk=>clk,
    dinero=>dinero_actual);
    
 comp: comparador
    Port map(
    dinero_act=>dinero_actual,
    precio=>precio,
    clk=>clk,
    reset=>reset,
    falta_dinero=>falta_dinero,
    dinero_justo=>dinero_justo,
    sobra_dinero=>sobra_dinero);
    
    dinero_act <= dinero_actual;
    
end Estructural;
