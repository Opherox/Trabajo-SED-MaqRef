library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_tb is
end contador_tb;

architecture Behavioral of contador_tb is
    constant CLOCK_PERIOD : time := 10 ps; -- Cambiar el período del reloj según necesidades
    
    signal cent10_tb, cent20_tb, cent50_tb, cent100_tb, reset_tb, clk_tb : std_logic := '0';
    signal dinero_tb : integer := 0;
    
    component contador
        Port(
            cent10: in std_logic;
            cent20: in std_logic;
            cent50: in std_logic;
            cent100: in std_logic;
            reset: in std_logic;
            clk: in std_logic;
            dinero: out integer
        );
    end component;
    
begin
    dut: contador port map(
        cent10 => cent10_tb,
        cent20 => cent20_tb,
        cent50 => cent50_tb,
        cent100 => cent100_tb,
        reset => reset_tb,
        clk => clk_tb,
        dinero => dinero_tb
    );
    
    -- Proceso para generar un reloj
    clk_process: process
    begin
        while now < 500 ps loop -- Cambiar el límite de tiempo según necesidades
            clk_tb <= '0';
            wait for CLOCK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    -- Estímulos de prueba
    stimulus_process: process
    begin
        reset_tb <= '1';
        wait for 10 ps;
        reset_tb <= '0';
        
        wait for 10 ps;
        cent10_tb <= '1';
        wait for CLOCK_PERIOD * 5;
        cent10_tb <= '0';
        
        wait for 10 ps;
        cent20_tb <= '1';
        wait for CLOCK_PERIOD * 3;
        cent20_tb <= '0';
        
        wait for 10 ps;
        cent50_tb <= '1';
        wait for CLOCK_PERIOD * 4;
        cent50_tb <= '0';
        
        wait for 10 ps;
        cent100_tb <= '1';
        wait for CLOCK_PERIOD * 6;
        cent100_tb <= '0';
        
        wait for 10 ps;
        cent100_tb <= '1';
        cent50_tb <= '1';
        wait for CLOCK_PERIOD * 6;
        cent100_tb <= '0';
        cent50_tb <= '0';
        
        wait for 10 ps;
        reset_tb <= '1';
        wait;
    end process;
    
end Behavioral;
