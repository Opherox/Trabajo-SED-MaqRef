library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Maquina_Estados_TB is
end Maquina_Estados_TB;

architecture testbench of Maquina_Estados_TB is

signal clk_tb : std_logic := '0';
signal B10C_tb, B20C_tb, B50C_tb, B100C_tb : std_logic := '0';
signal SW_P1_tb, SW_P2_tb, SW_P3_tb, SW_P4_tb : std_logic := '0';
signal Reset_tb : std_logic := '0';
signal Dinero_tb : integer := 0;
signal FD_tb, DJ_tb, SD_tb : std_logic := '0';
signal LEDS_E_D_tb : std_logic_vector (15 downto 0) := ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
signal Reset_D_tb : std_logic := '0';
signal SecuenciaSegm_tb : integer_vector (7 downto 0) := (0,0,0,0,0,0,0,0);
signal Precio_tb : integer := 10000;
signal IDetect_tb : std_logic := '1';

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
IDetect : out std_logic;
Precio: out integer;
SecuenciaSegm: out integer_vector (7 downto 0);
LEDS_E_D: out std_logic_vector (15 downto 0); --del 0 al 3 son LEDS para estados de la maquina, el 4 es el de error introduccion dinero.
Reset_D: out std_logic);
end component Maquina_Estados;

begin

    MEI : Maquina_Estados --Instancia de la maquina de estados
    Port map(
        B10C => B10C_tb,
        B20C => B20C_tb,
        B50C => B50C_tb,
        B100C => B100C_tb,
        SW_P1 => SW_P1_tb,
        SW_P2 => SW_P2_tb,
        SW_P3 => SW_P3_tb,
        SW_P4 => SW_P4_tb,
        clk => clk_tb,
        Reset => Reset_tb,
        Dinero => Dinero_tb,
        FaltaDinero => FD_tb,
        DineroJusto => DJ_tb,
        SobraDinero => SD_tb,
        IDetect => IDetect_tb,
        Precio => Precio_tb,
        SecuenciaSegm => SecuenciaSegm_tb,
        LEDS_E_D => LEDS_E_D_tb,
        Reset_D => Reset_D_tb    
        );  
  
  reloj_periodico : process --generar reloj de simulacion
  begin
    while now < 32000 ms loop
      CLK_tb <= not CLK_tb;
      wait for 1 ns; --frecuencia 1 nano segundo
    end loop;
    wait;
  end process;
    
  bloque_pruebas : process --proces de prueba de señales
    begin
    wait for 10 ns;
    B10C_tb <= '1';  
    wait for 20 ns;
    B10C_tb <= '0';
    SW_P1_tb <= '1';
    wait for 30 ns;
    SW_P1_tb <= '0';
    Reset_tb <= '1';
    wait for 40 ns;
    Reset_tb <= '0';
    wait for 50 ns;
    SW_P4_tb <= '1';
    wait for 600 ns;
    SW_P4_tb <= '0';
    wait for 40000 ns;
  end process;
                 
end testbench;
