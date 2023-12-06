library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SYNCHRNZR_tb is
end SYNCHRNZR_tb;

architecture Behavioral of SYNCHRNZR_tb is
  signal CLK_tb      : STD_LOGIC := '0';
  signal ASYNC_IN_tb : STD_LOGIC := '0';
  signal SYNC_OUT_tb : STD_LOGIC;
begin
  -- Instanciar la unidad bajo prueba (UUT)
  uut: entity work.SYNCHRNZR
    port map (
      CLK => CLK_tb,
      ASYNC_IN => ASYNC_IN_tb,
      SYNC_OUT => SYNC_OUT_tb
    );

  -- Proceso para generar el reloj
  process
  begin
    while now < 10000 ns loop
      CLK_tb <= not CLK_tb;
      wait for 100 ps; -- Cambia la frecuencia ajustando este valor
    end loop;
    wait;
  end process;

  -- Proceso para aplicar señales de prueba
  process
  begin
    ASYNC_IN_tb <= '0';
    wait for 500 ns;
    
    ASYNC_IN_tb <= '1';
    wait for 20 ns;

    wait;
  end process;

  -- Proceso para imprimir resultados
  process
  begin
    wait for 100 ns; -- Esperar a que el sistema se estabilice
    report "SYNC_OUT_tb = " & std_logic'image(SYNC_OUT_tb);
    wait;
  end process;

end Behavioral;
