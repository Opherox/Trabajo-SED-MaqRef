library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gestor_entradas_tb is
end gestor_entradas_tb;

architecture testbench of gestor_entradas_tb is
  signal clk_tb : std_logic := '0';
  signal boton10C_tb, boton20C_tb, boton50C_tb, boton100C_tb : std_logic := '0';
  signal bot10C_S_E_tb, bot20C_S_E_tb, bot50C_S_E_tb, bot100C_S_E_tb : std_logic;

  component gestor_entradas
    Port (
      boton10C: in std_logic;
      boton20C: in std_logic;
      boton50C: in std_logic;
      boton100C: in std_logic;
      clk: in std_logic;
      bot10C_S_E: out std_logic;
      bot20C_S_E: out std_logic;
      bot50C_S_E: out std_logic;
      bot100C_S_E: out std_logic);
  end component gestor_entradas;

  begin
    -- Instanciar el diseño
    UUT : gestor_entradas
      port map(
        boton10C => boton10C_tb,
        boton20C => boton20C_tb,
        boton50C => boton50C_tb,
        boton100C => boton100C_tb,
        clk => clk_tb,
        bot10C_S_E => bot10C_S_E_tb,
        bot20C_S_E => bot20C_S_E_tb,
        bot50C_S_E => bot50C_S_E_tb,
        bot100C_S_E => bot100C_S_E_tb
      );

    -- Proceso de simulación del reloj
    process
    begin
      while now < 1000 ns  -- Establece la duración de la simulación
        loop
          clk_tb <= not clk_tb;
          wait for 1 ps;  -- Ajusta la frecuencia del reloj según sea necesario
        end loop;
        wait;
    end process;

    -- Proceso de estimulación
    process
    begin
      -- Inicia los pulsos de los botones
      boton10C_tb <= '0';
      boton20C_tb <= '0';
      boton50C_tb <= '0';
      boton100C_tb <= '0';
      
      wait for 10 ns;
      
      boton10C_tb <= '1';
      wait for 100 ns;
      boton10C_tb <= '0';

      wait for 100 ns;

      boton20C_tb <= '1';
      wait for 100 ns;
      boton20C_tb <= '0';

      wait for 100 ns;

      boton50C_tb <= '1';
      wait for 100 ns;
      boton50C_tb <= '0';

      wait for 100 ns;

      boton100C_tb <= '1';
      wait for 100 ns;
      boton100C_tb <= '0';

      wait;
    end process;

  end testbench;
