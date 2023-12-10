library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDCTR_TB is
end EDGEDCTR_TB;

architecture TB_ARCH of EDGEDCTR_TB is
    signal CLK_TB : STD_LOGIC := '0';
    signal SYNC_IN_TB : STD_LOGIC := '0';
    signal EDGE_TB : STD_LOGIC;

    component EDGEDCTR
        Port ( 
            CLK : in STD_LOGIC;
            SYNC_IN : in STD_LOGIC;
            EDGE : out STD_LOGIC
        );
    end component;

    constant CLK_PERIOD : time := 50 ns; -- Ajusta el periodo del reloj según sea necesario
begin

    -- Instancia del componente EDGEDCTR
    UUT: EDGEDCTR
        port map (
            CLK => CLK_TB,
            SYNC_IN => SYNC_IN_TB,
            EDGE => EDGE_TB
        );

    -- Proceso para generar el reloj
    CLK_GEN_PROCESS: process
    begin
        while now < 1000 ns loop
            CLK_TB <= not CLK_TB;
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Proceso para aplicar la señal SYNC_IN
    SYNC_IN_PROCESS: process
    begin
        wait for 200 ns; -- Espera un tiempo antes de aplicar SYNC_IN
        SYNC_IN_TB <= '1';
        wait for 200 ns; -- Mantén SYNC_IN en '1'
        SYNC_IN_TB <= '0';
        wait for 200 ns; -- Espera un tiempo antes de aplicar SYNC_IN
        SYNC_IN_TB <= '1';
        wait for 200 ns; -- Mantén SYNC_IN en '1'
        SYNC_IN_TB <= '0';
        wait;
    end process;

end TB_ARCH;
