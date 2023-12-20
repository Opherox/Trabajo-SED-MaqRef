library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Gestor_Dinero is
    Port(
        cent10 : in std_logic; -- entrada de 10 centimos
        cent20 : in std_logic; -- entrada de 20 centimos
        cent50 : in std_logic; -- entrada de 50 centimos
        cent100 : in std_logic; -- entrada de 100 centimos
        clk : in std_logic; -- reloj general
        reset : in std_logic; -- reset general
        Reset_D : in std_logic; -- CE para desabilitar los dispositivos
        precio : in integer; -- precio del producto
        falta_dinero : out std_logic; -- señal de que falta dinero
        sobra_dinero : out std_logic; -- señal de que sobra 
        dinero_justo : out std_logic; -- señal de dinero justo
        dinero_act : out integer); -- dinero actual introducido
end Gestor_Dinero;

architecture Estructural of Gestor_Dinero is
    
    component comparador is -- declaracion del la entidad comparador
        Port(
        dinero_act : in integer;
        precio : in integer;
        clk : in std_logic;
        reset : in std_logic;
        Reset_D : in std_logic; 
        falta_dinero : out std_logic;
        dinero_justo : out std_logic;
        sobra_dinero : out std_logic);
     end component;
     
     component contador is -- declaracion de la entidad contador
        Port(
        cent10 : in std_logic;
        cent20 : in std_logic;
        cent50 : in std_logic;
        cent100 : in std_logic;
        reset : in std_logic;
        Reset_D : in std_logic;
        clk : in std_logic;
        dinero : out integer); 
     end component;
     
signal dinero_actual : integer := 0; -- señal interna para conectar los componenetes: dinero actual introducido
     
begin

 cont: contador -- mapeado de las señales del contador
    Port map(
    cent10=>cent10,
    cent20=>cent20,
    cent50=>cent50,
    cent100=>cent100,
    reset=>reset,
    Reset_D => Reset_D, 
    clk=>clk,
    dinero=>dinero_actual);
    
 comp: comparador -- mapeado de las señales del comparador
    Port map(
    dinero_act=>dinero_actual,
    precio=>precio,
    clk=>clk,
    reset=>reset,
    Reset_D => Reset_D, 
    falta_dinero=>falta_dinero,
    dinero_justo=>dinero_justo,
    sobra_dinero=>sobra_dinero);
    
    dinero_act <= dinero_actual; -- se asigna la variable interna a la salida
    
end Estructural;
