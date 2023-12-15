library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Maquina_Estados_TB is
end Maquina_Estados_TB;

architecture testbench of Maquina_Estados_TB is
signal clk_tb : std_logic := '0';
signal B10C_tb, B20C_tb, B50C_tb, B100C_tb : std_logic := '0';
signal SW_P1_tb, SW_P2_tb, SW_P3_tb, SW_4_tb : std_logic := '0';
signal Reset_tb : std_logic := '0';
signal Dinero_tb : integer := 0;
signal FD_tb, DJ_tb, SD_tb : std_logic := '0';

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
Precio: out integer;
SecuenciaSegm: out integer_vector (7 downto 0);
LEDS_E_D: out std_logic_vector (15 downto 0); --del 0 al 3 son LEDS para estados de la maquina, el 4 es el de error introduccion dinero.
Reset_D: out std_logic);
end component Maquina_Estados;

begin


end testbench;
