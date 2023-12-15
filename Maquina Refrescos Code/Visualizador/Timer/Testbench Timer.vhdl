library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Timer_TB is
--  Port ( );
end Timer_TB;

architecture testbench of Timer_TB is

signal clk_tb : std_logic := '0';
signal Reset_tb : std_logic := '0';
signal Divider_tb : integer := 10;
signal clk_o_tb : std_logic; 

component Timer
Port(
    clk : in std_logic;
    Reset : in std_logic;
    Divider : in integer;
    clk_o : out std_logic   
    );
end component Timer;
begin

TI : Timer
Port map(
    clk => clk_tb,
    Reset => Reset_tb,
    Divider => Divider_tb,
    clk_o => clk_o_tb    
    );

reloj_simulacion : process
begin
    while now < 1000 ms loop
        clk_tb <= not clk_tb;
        wait for 10 ns;
    end loop;
    wait; 
end process;

bloque_pruebas : process
begin
    wait for 20 ns;
    Reset_tb <= '1';
    wait for 30 ns;
    Reset_tb <= '0';
    wait for 530 ns;
end process;

end testbench ;
