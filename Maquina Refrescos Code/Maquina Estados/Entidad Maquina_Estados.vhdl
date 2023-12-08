library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Maquina_Estados is
Port (
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
end Maquina_Estados;

architecture Behavioral of Maquina_Estados is

type Estados is (E0,E1,E2,E3);
signal EstadoActual: Estados := E0;
signal EstadoSiguiente: Estados;
signal InactividadDetectada: std_logic := '1'; --para deteccion de inactividad y consecuente paso a reposo
signal SwitchesProductos: std_logic_vector  (3 downto 0) := "0000";
signal BotonesMonedas: std_logic_vector  (3 downto 0) := "0000";

begin

SwitchesProductos <= (SW_P4,SW_P3,SW_P2,SW_P1); --hacer un vector de interruptores para mas facilidad de uso (cases) 
BotonesMonedas <= (B100C,B50C,B20C,B10C); --hacer un vector de botones para mas facilidad de uso (cases)  

Actualizador_inactividad: process (SW_P1,SW_P2,SW_P3,SW_P4,B10C,B20C,B50C,B100C)
    begin
    --si hay alguien tocando alguna entrada no hay inactividad
    if BotonesMonedas = "0000" then
        case SwitchesProductos is  
            when "0000" => InactividadDetectada <= '1' after 30000 ms;
            when others => InactividadDetectada <= '0'; --en teoria prevalece la segunda asignacion, si pasan 30 s desde que no hubo actividad pero esta habiendo actividad no estara InactividadDecectada a 1
        end case;
    elsif SwitchesProductos = "0000" then
        case BotonesMonedas is
            when "0000" => InactividadDetectada <= '1' after 30000 ms;
            when others => InactividadDetectada <= '0';
        end case;
    end if;     
    end process;

Registro_estados: process (RESET, CLK) --cambios estado sincronizados por reloj o reset asincrono
    begin
    if Reset = '0' then 
       EstadoActual <= E0;
       InactividadDetectada <= '1';
    elsif rising_edge (clk) then
       EstadoActual <= EstadoSiguiente;
    end if;
    end process;    

Actualizador_estados: process (InactividadDetectada,DineroJusto, EstadoActual)
    begin
        if InactividadDetectada = '1' then              --si se detecta inactividad desde cualquier estado se vuelve al estado E0 (reposo)
            EstadoSiguiente <= E0;
        elsif InactividadDetectada = '0' then           --si hay actividad se procede a cambios diferentes
            if EstadoActual = E0 then                   --actividad en el estado de reposo supone pasar a E1 (seleccion de producto)
                Reset_D <= '1';                         --no se permite contar dinero si no estas en el estado correspondiente
                EstadoSiguiente <= E1;
            elsif EstadoActual = E1 then                --en estado E1, dependiendo del producto elegido el precio se pone a algo, pero se pasa a E2 (insertar monedas)
                Reset_D <= '1';                         --no se permite contar dinero si no estas en el estado correspondiente
                case SwitchesProductos is
                    when "0001" => EstadoSiguiente <= E2; Precio <= 100; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    when "0010" => EstadoSiguiente <= E2; Precio <= 120; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    when "0100" => EstadoSiguiente <= E2; Precio <= 150; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    when "1000" => EstadoSiguiente <= E2; Precio <= 200; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    when others => EstadoSiguiente <= E1; --si hay dos interruptores, o mas, o ninguno accionados no se selecciona un producto (mas robusto)
                end case; 
            elsif EstadoActual = E2 then                --transiciones desde estado introducir dinero
                if DineroJusto = '1' then               --si dinero justo ir a estado entregar producto
                    EstadoSiguiente <= E3;
                elsif SobraDinero = '1' then            --si sobra dinero error y devolver producto
                    EstadoSiguiente <= E1;
                    LEDS_E_D(4) <= '1', '0' after 2000 ms;  --4 LED de error de dinero se enciende si se mete cantidad no exacta superando el precio
                elsif FaltaDinero = '1' then
                    EstadoSiguiente <= E2;
                end if;
            elsif EstadoActual = E3 then
                Reset_D <= '1';                         --no se permite contar dinero si no estas en el estado correspondiente
                EstadoSiguiente <= E0 after 5000 ms;    --despues de 5 segundos se vuelve a estado reposo (tiempo de entrega producto)      
            end if;
        end if;
    end process;

Gestor_Salidas_LED_Estados: process (EstadoActual)
    begin
    case EstadoActual is
        when E0 => LEDS_E_D(0) <= '1'; LEDS_E_D(1) <= '0'; LEDS_E_D(2) <= '0'; LEDS_E_D(3) <= '0'; --si en estado reposo solo enciende LED estado R
        when E1 => LEDS_E_D(1) <= '1'; LEDS_E_D(0) <= '0'; LEDS_E_D(2) <= '0'; LEDS_E_D(3) <= '0'; --si en estado seleccion producto solo enciende LED estado SP
        when E2 => LEDS_E_D(2) <= '1'; LEDS_E_D(0) <= '0'; LEDS_E_D(1) <= '0'; LEDS_E_D(3) <= '0'; --si en estado introducir dinero solo enciende LED estado ID
        when E3 => LEDS_E_D(3) <= '1'; LEDS_E_D(0) <= '0'; LEDS_E_D(1) <= '0'; LEDS_E_D(2) <= '0'; --si en estado entregar producto solo enciende LED estado EP
    end case;
    end process;

end Behavioral;
