library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MaquinaRefrescos_tb is
--  Port ( );
end MaquinaRefrescos_tb;

architecture Behavioral of MaquinaRefrescos_tb is

component Maquina_Refrescos
Port(
    Bot : in std_logic_vector (3 downto 0);    
    SW : in std_logic_vector (3 downto 0);
    clk : in std_logic;
    Reset : in std_logic;
    Segm : out std_logic_vector (6 downto 0);
    DigSel : out std_logic_vector (7 downto 0); 
    LED : out std_logic_vector (15 downto 0)   
    );
end component Maquina_Refrescos;

signal Bot_tb : std_logic_vector (3 downto 0) := "0000";
signal SW_tb : std_logic_vector (3 downto 0) := "0000";
signal clk_tb : std_logic := '0';
signal Reset_tb : std_logic := '1';
signal Segm_tb : std_logic_vector (6 downto 0) := "1111111";
signal DigSel_tb : std_logic_vector (7 downto 0) := "11111111";
signal LED_tb : std_logic_vector (15 downto 0) := "0000000000000000";

begin

    MR_I : Maquina_Refrescos 
    port map(
        Bot => Bot_tb,
        SW => SW_tb,
        clk => clk_tb,
        Reset => Reset_tb,
        Segm => Segm_tb,
        DigSel => DigSel_tb,
        LED => LED_tb       
        );

Reloj : process 
begin
    clk_tb <= not clk_tb;
    wait for 10 ns;  
end process;

Pruebas : process 
begin
    wait for 100 ns;
    Bot_tb(1) <= '1';
    wait for 200 ns;
    Bot_tb(1) <= '0';  
    wait for 300 ns;
    SW_tb(1) <= '1';  
    wait for 400 ns;
    SW_tb(1) <= '0';  
    wait for 1000 ns;
    
end process; 

end Behavioral;
