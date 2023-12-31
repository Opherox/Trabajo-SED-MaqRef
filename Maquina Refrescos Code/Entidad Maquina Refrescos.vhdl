library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity Maquina_Refrescos is
Port (
    Bot : in std_logic_vector (3 downto 0);    
    SW : in std_logic_vector (3 downto 0);
    clk : in std_logic;
    Reset : in std_logic;
    Segm : out std_logic_vector (6 downto 0);
    DigSel : out std_logic_vector (7 downto 0); 
    LED : out std_logic_vector (15 downto 0)   
    );
end Maquina_Refrescos;

architecture Behavioral of Maquina_Refrescos is

component gestor_entradas
Port(
    boton10C: in std_logic;
    boton20C: in std_logic;
    boton50C: in std_logic;
    boton100C: in std_logic;
    clk: in std_logic;
    bot10C_S_E: out std_logic;
    bot20C_S_E: out std_logic;
    bot50C_S_E: out std_logic;
    bot100C_S_E: out std_logic
    );
end component gestor_entradas;

component Gestor_Dinero
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
    dinero_act : out integer
    );
end component Gestor_Dinero;

component Maquina_Estados
Port(
    SW_P1: in std_logic;
    SW_P2: in std_logic;
    SW_P3: in std_logic;
    SW_P4: in std_logic;
    B10C: in std_logic;
    B20C: in std_logic; 
    B50C: in std_logic; 
    B100C: in std_logic;
    clk: in std_logic;
    Reset: in std_logic;
    Dinero: in integer;
    FaltaDinero: in std_logic;
    DineroJusto: in std_logic;
    SobraDinero: in std_logic;
    --IDetect : out std_logic;    --PARA PRUEBAS, LUEGO COMENTAR
    Precio: out integer;
    SecuenciaSegm: out integer_vector (7 downto 0);
    LEDS_E_D: out std_logic_vector (15 downto 0); --LEDS de estado(0,3) y LED error dinero(4) y LED devolver dinero(5), LED inactividad(6), LED reset on (15)
    Reset_D: out std_logic
    );
end component Maquina_Estados;

component Visualizador
Port(
    clk : in std_logic;
    Reset : in std_logic;
    Secuencia_Segm : in integer_vector (7 downto 0);  
    Segm : out std_logic_vector (6 downto 0);
    DigSel : out std_logic_vector (7 downto 0)
    );
end component Visualizador;

signal Bot_S_E : std_logic_vector (3 downto 0) := "0000";
signal Precio_S : integer := 10000;
signal FaltaDinero_S : std_logic := '0';
signal SobraDinero_S : std_logic := '0';
signal DineroJusto_S : std_logic := '0';
signal Dinero_S : integer := 0;     
signal Reset_D_S : std_logic := '0';
signal SecuenciaSegm_S : integer_vector (7 downto 0) := (others=> 0);
signal Segm_S : std_logic_vector (6 downto 0) := "1111110";
signal DigSel_S : std_logic_vector (7 downto 0) := "11111111";
signal LED_S : std_logic_vector (15 downto 0) := "0000000000000000";
signal Reset_S : std_logic := '1';

begin

Reset_S <= not Reset;

    GE_I: gestor_entradas
    port map(
        boton10C => Bot(0),
        boton20C => Bot(1),
        boton50C => Bot(2),
        boton100C => Bot(3),
        clk => clk,
        bot10C_S_E => Bot_S_E(0),
        bot20C_S_E => Bot_S_E(1),
        bot50C_S_E => Bot_S_E(2),
        bot100C_S_E => Bot_S_E(3)
        );
        
    GD_I : Gestor_Dinero
    port map(
        cent10 => Bot_S_E(0),
        cent20 => Bot_S_E(1),
        cent50 => Bot_S_E(2),
        cent100 => Bot_S_E(3),
        clk => clk,
        reset => Reset_S,
        Reset_D => Reset_D_S, 
        precio => Precio_S,
        falta_dinero => FaltaDinero_S,
        sobra_dinero => SobraDinero_S,
        dinero_justo => DineroJusto_S,
        dinero_act => Dinero_S
        );
    
    ME_I: Maquina_Estados
    port map(
        SW_P1 => SW(0),
        SW_P2 => SW(1),
        SW_P3 => SW(2),
        SW_P4 => SW(3),
        B10C => Bot_S_E(0),
        B20C => Bot_S_E(1), 
        B50C => Bot_S_E(2), 
        B100C => Bot_S_E(3),
        clk => clk,
        Reset => Reset_S,
        Dinero => Dinero_S,
        FaltaDinero => FaltaDinero_S,
        DineroJusto => DineroJusto_S,
        SobraDinero => SobraDinero_S,
        --IDetect : out std_logic;    --PARA PRUEBAS, LUEGO COMENTAR
        Precio => Precio_S,
        SecuenciaSegm => SecuenciaSegm_S,
        LEDS_E_D => LED_S, --del 0 al 3 son LEDS para estados de la maquina, el 4 es el de error introduccion dinero, el 5 devolucion de dinero, el 6 LED inactividad, el LED 15 indicador reset
        Reset_D => Reset_D_S
        );
        
    V_I : Visualizador
    port map(
        clk => clk,
        Reset => Reset_S,
        Secuencia_Segm => SecuenciaSegm_S,  
        Segm => Segm_S,
        DigSel => DigSel_S
        );  
         
Segm <= Segm_S;
DigSel <= DigSel_S;
LED <= LED_S; 
         
end Behavioral;
