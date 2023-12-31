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
--IDetect : out std_logic;    --PARA PRUEBAS, LUEGO COMENTAR
Precio: out integer;
SecuenciaSegm: out integer_vector (7 downto 0);
LEDS_E_D: out std_logic_vector (15 downto 0); --del 0 al 3 son LEDS para estados de la maquina, el 4 es el de error introduccion dinero.
Reset_D: out std_logic);
end Maquina_Estados;

architecture Behavioral of Maquina_Estados is

type Estados is (E0,E1,E2,E3);

constant Frecuencia_Reloj : integer := 100000000; --100 para poder verlo en los testbench; --100MHz (reloj de la Nexys DDR4)
--constant Longitud_Contador : natural := 128; --ajustable por si hay sobrepaso de tamaño

signal EstadoActual: Estados := E0;
signal EstadoSiguiente: Estados;
signal InactividadDetectada: std_logic := '1'; --para deteccion de inactividad y consecuente paso a reposo
--signal SwitchesProductos: std_logic_vector  (3 downto 0) := "0000";
--signal BotonesMonedas: std_logic_vector  (3 downto 0) := "0000";
signal Precio_s: integer := 1000000;
signal SecuenciaSegm_s: integer_vector (7 downto 0):= (others => 0);
signal Contador_R : integer := Frecuencia_Reloj;
signal Contador_S : integer := 30;
signal Contador_ED : integer := 0;
signal Contador_E3 : integer := 5*Frecuencia_Reloj;
begin

--SwitchesProductos <= (SW_P4,SW_P3,SW_P2,SW_P1); --hacer un vector de interruptores para mas facilidad de uso (cases) 
--BotonesMonedas <= (B100C,B50C,B20C,B10C); --hacer un vector de botones para mas facilidad de uso (cases)  

Actualizador_inactividad: process (clk,B100C,B50C,B20C,B10C,SW_P4,SW_P3,SW_P2,SW_P1,Reset)        --Gestiona Inactividad, si hay alguien tocando alguna entrada Inactividad a 0, si un rato sin tocar Inactividad a 1
    begin
    if Reset = '1' then
        Contador_R <= Frecuencia_Reloj;
        Contador_S <= 30;      
        InactividadDetectada <= '1'; 
    elsif rising_edge(clk) then
        if B100C = '0' and B50C = '0' and B20C = '0' and B10C = '0' and SW_P1 = '0' and SW_P1 = '0' and SW_P2 = '0' and SW_P3 = '0' and SW_P4 = '0' then
        --if BotonesMonedas = "0000" and SwitchesProductos = "0000" then --botones sin pulsar y switches sin accionar
            if Contador_S < 30 then --si no han pasado 30 segundos sigue contando
                if Contador_R /= 0 then
                    Contador_R <= Contador_R - 1;
                elsif Contador_R = 0 then   --si se cuenta 1s se suma al contador de segundos
                    Contador_S <= Contador_S + 1;
                    Contador_R <= Frecuencia_Reloj;
                end if;
            elsif Contador_S = 30 then
                InactividadDetectada <= '1';  --si han pasado 30 segundos se detecta inactividad
            end if;       
        elsif B100C = '1' or B50C = '1' or B20C = '1' or B10C = '1' or SW_P1 = '1' or SW_P1 = '1' or SW_P2 = '1' or SW_P3 = '1' or SW_P4 = '1' then --actividad en la entrada implica reiniciar el contador y no detectar actividad
            Contador_R <= Frecuencia_Reloj;
            Contador_S <= 0;
            InactividadDetectada <= '0';
        end if;  
    end if;
    --IDetect <= InactividadDetectada;     
    end process;

Registro_estados: process (RESET, CLK) --cambios estado sincronizados por reloj o reset asincrono
    begin
    if Reset = '1' then 
       EstadoActual <= E0;
    elsif rising_edge (clk) then
       EstadoActual <= EstadoSiguiente;
    end if;
    end process;    

Actualizador_estados: process (clk,InactividadDetectada, EstadoActual, SW_P4,SW_P3,SW_P2,SW_P1, DineroJusto, SobraDinero, FaltaDinero)        --gestiona cambio de estados y outputs de reset_dinero y asignacion precio
    begin
        if Reset = '1' then
            EstadoSiguiente <= E0;
            Reset_D <= '1';
            Contador_E3 <= 5 * Frecuencia_Reloj; 
        elsif rising_edge(clk) then
            if InactividadDetectada = '1' then              --si se detecta inactividad desde cualquier estado se vuelve al estado E0 (reposo)
                EstadoSiguiente <= E0;
                Reset_D <= '1';
            elsif InactividadDetectada = '0' then           --si hay actividad se procede a cambios diferentes
                if EstadoActual = E0 then                   --actividad en el estado de reposo supone pasar a E1 (seleccion de producto)
                    EstadoSiguiente <= E1;
                    Reset_D <= '1';                         --no se permite contar dinero si no estas en el estado correspondiente
                elsif EstadoActual = E1 then                --en estado E1, dependiendo del producto elegido el precio se pone a algo, pero se pasa a E2 (insertar monedas)            
                    if SW_P4 = '0' and SW_P3 = '0' and SW_P2 = '0' and SW_P1 = '1' then
                        EstadoSiguiente <= E2; Precio_s <= 100; Reset_D <= '0';     --no se permite contar dinero si no estas en el estado correspondiente
                    elsif SW_P4 = '0' and SW_P3 = '0' and SW_P2 = '1' and SW_P1 = '0' then
                        EstadoSiguiente <= E2; Precio_s <= 120; Reset_D <= '0';     --no se permite contar dinero si no estas en el estado correspondiente
                    elsif SW_P4 = '0' and SW_P3 = '1' and SW_P2 = '0' and SW_P1 = '0' then
                        EstadoSiguiente <= E2; Precio_s <= 150; Reset_D <= '0';     --no se permite contar dinero si no estas en el estado correspondiente
                    elsif SW_P4 = '1' and SW_P3 = '0' and SW_P2 = '0' and SW_P1 = '0' then
                        EstadoSiguiente <= E2; Precio_s <= 200; Reset_D <= '0';     --no se permite contar dinero si no estas en el estado correspondiente
                    else
                         EstadoSiguiente <= E1; Reset_D <= '1';
                    end if;
                    --case SwitchesProductos is
                    --    when "0001" => EstadoSiguiente <= E2; Precio_s <= 100; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    --    when "0010" => EstadoSiguiente <= E2; Precio_s <= 120; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    --    when "0100" => EstadoSiguiente <= E2; Precio_s <= 150; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    --    when "1000" => EstadoSiguiente <= E2; Precio_s <= 200; Reset_D <= '0';             --ahora si se permitira contar dinero al contador
                    --    when others => EstadoSiguiente <= E1; Reset_D <= '1';--si hay dos interruptores, o mas, o ninguno accionados no se selecciona un producto (mas robusto)
                    --end case; 
                elsif EstadoActual = E2 then                --transiciones desde estado introducir dinero
                    if DineroJusto = '1' then               --si dinero justo ir a estado entregar producto
                        EstadoSiguiente <= E3;
                        Reset_D <= '1';
                    elsif SobraDinero = '1' then            --si sobra dinero error y devolver producto
                        EstadoSiguiente <= E1;
                        Reset_D <= '1';
                        --LEDS_E_D(4) <= '1', '0' after 2000 ms;  --4 LED de error de dinero se enciende si se mete cantidad no exacta superando el precio. No se si deberia quedarse aqui o en el gestor de LEDS (process) por temas de fugacidad
                    elsif FaltaDinero = '1' then    
                        EstadoSiguiente <= E2;
                        Reset_D <= '0';
                    end if;
                elsif EstadoActual = E3 then
                    Reset_D <= '1';                         --no se permite contar dinero si no estas en el estado correspondiente
                    if Contador_E3 > 0 then
                        Contador_E3 <= Contador_E3 - 1;
                    elsif Contador_E3 = 0 then              --despues de 5 segundos se vuelve a estado reposo (tiempo de entrega producto)                       
                        EstadoSiguiente <= E0;     
                        Contador_E3 <= 5 * Frecuencia_Reloj;
                    end if;           
                end if;
            end if;
        end if;    
    end process;
    
Gestor_Precio: process (clk,EstadoActual)
    begin
        if rising_edge(clk) then
            if EstadoActual = E0 then
                Precio <= 1000000;
            elsif EstadoActual = E1 then
                Precio <= 1000000;
            elsif EstadoActual = E2 then
                Precio <= Precio_s; 
            elsif EstadoActual = E3 then
                Precio <= Precio_s;
            end if;
        end if;   
    end process;
     
Gestor_Salidas_LED: process (clk, EstadoActual, SobraDinero, InactividadDetectada)      --gestor LEDS de estado(0,3) y LED error dinero(4) y LED devolver dinero(5), LED inactividad(6), LED reset on (15)
    begin
        if rising_edge(clk) then
            case EstadoActual is
                when E0 => LEDS_E_D(0) <= '1'; LEDS_E_D(1) <= '0'; LEDS_E_D(2) <= '0'; LEDS_E_D(3) <= '0'; LEDS_E_D(5) <= '1'; --si en estado reposo solo enciende LED estado R y se devuelven monedas
                when E1 => LEDS_E_D(1) <= '1'; LEDS_E_D(0) <= '0'; LEDS_E_D(2) <= '0'; LEDS_E_D(3) <= '0'; LEDS_E_D(5) <= '1'; --si en estado seleccion producto solo enciende LED estado SP y se devuelven monedas
                when E2 => LEDS_E_D(2) <= '1'; LEDS_E_D(0) <= '0'; LEDS_E_D(1) <= '0'; LEDS_E_D(3) <= '0'; LEDS_E_D(5) <= '0'; --si en estado introducir dinero solo enciende LED estado ID, no se devuelven monedas
                when E3 => LEDS_E_D(3) <= '1'; LEDS_E_D(0) <= '0'; LEDS_E_D(1) <= '0'; LEDS_E_D(2) <= '0'; LEDS_E_D(5) <= '1'; --si en estado entregar producto solo enciende LED estado EP y se devuelven monedas
            end case;
            if SobraDinero = '1' then
                LEDS_E_D(4) <='1';           --si sobra dinero se enciende LED error dinero
                Contador_ED <= 200000000;    --20 para verlo en testbench   --2 segundos de led error de dinero encendido
            else
                if Contador_ED /= 0 then
                    Contador_ED <= Contador_ED -1;
                elsif Contador_ED = 0 then
                    LEDS_E_D(4)<= '0';           --tras 2 segundos se apaga
                end if;
            end if;
            if InactividadDetectada = '1' then
                LEDS_E_D(6) <= '1';
            else 
                LEDS_E_D(6) <= '0';
            end if;
            if Reset = '1' then
                LEDS_E_D(15) <= '1';
            else 
                LEDS_E_D(15) <= '0';
            end if; 
            for i in 7 to 14 loop
                LEDS_E_D(i) <= '0';
            end loop;
        end if;
    end process;

Gestor_Display_7Segmentos: process (clk, EstadoActual, Dinero, Precio_s)       --gestiona los valores a mandar al visualizador dependiendo del estado, el dinero y el precio
    variable Diferencia : integer := Precio_s;                      --Dinero restante para dinero justo, en verdad para lo poco que se usa se podria poner la operacion directamente
    begin
        if rising_edge(clk) then
            Diferencia := Precio_s-Dinero;
            if EstadoActual = E2 then   --En estado introducir dinero mostrar dinero restante para dinero justo
                SecuenciaSegm_s(0) <= 0;                               --unidades, no va a haber nunca
                SecuenciaSegm_s(1) <= (Diferencia/10) mod 10;          --decenas, resto de dividir Diferencia/10 entre 10
                SecuenciaSegm_s(2) <= (Diferencia/100);                --centenas, division exacta de Diferencia/100
                SecuenciaSegm_s(3) <= 0;                               --miles, no va a haber nunca
            elsif EstadoActual = E3 then    --En estado entrega producto mostrar el producto a entregar
                case Precio_s is
                    when 100 => SecuenciaSegm_s(0) <= 1; SecuenciaSegm_s(1) <= 9+16; --P1, 16 es el lugar que ocupa la P en el abecedario ingles (tocara convetirlo a segmentos)
                    when 120 => SecuenciaSegm_s(0) <= 2; SecuenciaSegm_s(1) <= 9+16; --P2, 16 es el lugar que ocupa la P en el abecedario ingles (tocara convetirlo a segmentos)
                    when 150 => SecuenciaSegm_s(0) <= 3; SecuenciaSegm_s(1) <= 9+16; --P3, 16 es el lugar que ocupa la P en el abecedario ingles (tocara convetirlo a segmentos)
                    when 200 => SecuenciaSegm_s(0) <= 4; SecuenciaSegm_s(1) <= 9+16; --P4, 16 es el lugar que ocupa la P en el abecedario ingles (tocara convetirlo a segmentos)
                    when others => SecuenciaSegm_s(0) <= 9+27; SecuenciaSegm_s(1) <= 9+27; --Representar --
                end case;
                for i in 2 to 5 loop
                    SecuenciaSegm_s(i) <= 9+27;                                    --Rellenar con - los displays no usados
                end loop;
            else                                                                 --En los demas estados no se usan los displays
                for i in 0 to 5 loop
                    SecuenciaSegm_s(i) <= 9+27;                                    --Rellenar con - los displays no usados
                end loop;
            end if;
            SecuenciaSegm_s(6) <= Contador_S mod 10;        --unidades de segundos del tiempo de inactividad transcurrido
            SecuenciaSegm_s(7) <= Contador_S/10;            --decenas de segundos del tiempo de inactividad transcurrido 
            SecuenciaSegm <= SecuenciaSegm_s;               --pasar todos los valores a la salida para que vayan al visualizador
        end if;    
    end process;       

end Behavioral;
