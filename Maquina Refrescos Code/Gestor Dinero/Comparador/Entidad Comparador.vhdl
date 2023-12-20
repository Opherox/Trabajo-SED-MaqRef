library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparador is
Port(
    dinero_act: in integer; -- dinero actual acumulado
    Precio: in integer; -- precio del producto
    clk: in std_logic; -- reloj general
    reset: in std_logic -- reset general
    Reset_D : in std_logic; -- CE para habilitar el dispositivo 
    falta_dinero: out std_logic; -- salida de que falta dinero
    dinero_justo: out std_logic; -- salida de que esta el dinero exacto
    sobra_dinero: out std_logic); -- salida de que se ha introducido dinero de mas
end comparador;

architecture Behavioral of comparador is
begin
    
    process(clk,reset,Reset_D)
    variable resultado : integer := Precio; -- variable interna para la difrerencia entre precio y dinero actual

    begin
    
    if reset = '1' or Reset_D = '1' then -- si se activa el reset general o se desabilita el dispositivo
        resultado := Precio; 
        dinero_justo <= '0'; 
        falta_dinero <= '0';
        sobra_dinero <= '0';
    elsif rising_edge(clk) then -- si hay un flaco de reloj positivo
        resultado := precio - dinero_act; -- calcula la diferencia
        if resultado = 0 then -- si la diferencia es 0
            dinero_justo <= '1';
            falta_dinero <= '0';
            sobra_dinero <= '0';
        elsif resultado < 0 then -- si la diferencia es negativa (hay mas dinero del necesario)
            dinero_justo <= '0';
            falta_dinero <= '0';
            sobra_dinero <= '1';
        elsif resultado > 0 then -- si la diferencia es positiva (hay menos dinero del necesario)
            dinero_justo <= '0';
            falta_dinero <= '1';
            sobra_dinero <= '0';
        end if;
    end if;
    end process;
    
end Behavioral;
