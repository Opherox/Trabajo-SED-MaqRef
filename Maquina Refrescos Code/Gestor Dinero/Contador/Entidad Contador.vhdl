library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
Port(
    cent10: in std_logic;  --entrada moneda 10 centimos
    cent20: in std_logic;  --entrada moneda 20 centimos
    cent50: in std_logic;  --entrada moneda 50 centimos
    cent100: in std_logic;  --entrada moneda 1 euro
    reset: in std_logic;  --reset del contador (viene del reset general)
    Reset_D : in std_logic; 
    clk: in std_logic;  --reloj del sistema
    dinero: out integer);   --valor contado total en numerico (para facilidad de uso en el comparador)
end contador;

architecture Behavioral of contador is

--signal entradas: std_logic_vector(3 downto 0) := "0000";  --señal auxiliar para poder hacer un case para combinaciones
-- signal cuenta: integer := 0;  

begin

--entradas <= (cent100,cent50,cent20,cent10);  --convertimos las 4 entradas logicas en un vector
    process(clk,reset)  --process que solo varia cuando hay una variacion en el reloj o en reset (sincronizado)
    variable cuenta : integer := 0; --variable auxiliar para contado dinero
    begin
        if reset = '1' or Reset_D = '1' then 
            cuenta := 0;  --si se produce un reset la cuenta a 0
        elsif rising_edge(clk) then
            if cent10 = '0' and cent20 = '0' and cent50 = '0' and cent100 = '1' then
                cuenta := cuenta + 10;
            elsif cent10 = '0' and cent20 = '0' and cent50 = '1' and cent100 = '0' then
                cuenta := cuenta + 20;
            elsif cent10 = '0' and cent20 = '1' and cent50 = '0' and cent100 = '0' then
                cuenta := cuenta + 50;
            elsif cent10 = '1' and cent20 = '0' and cent50 = '0' and cent100 = '0' then
                cuenta := cuenta + 100;
            end if;    
            --case entradas is
            --    when "0001" => cuenta := cuenta+10;  --si hay flanco positivo en boton 10 centimos se suma 10 a cuenta
            --    when "0010" => cuenta := cuenta+20;  --si hay flanco positivo en boton 20 centimos se suma 20 a cuenta
            --    when "0100" => cuenta := cuenta+50;  --si hay flanco positivo en boton 50 centimos se suma 50 a cuenta
            --    when "1000" => cuenta := cuenta+100;  --si hay flanco positivo en boton 100 centimos se suma 100 a cuenta
            --    when OTHERS => cuenta := cuenta;  --si se pulsan varios botones a la vez la maquina no suma (seria imposible meter 2 monedas a la vez)
            --end case;
        end if;
        dinero <= cuenta; --a la salida se asigna a dinero el valor de la cuenta
     end process;
     
end Behavioral;
