library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gen_secuencias is
    Generic(N:Positive:=8); -- generico para numero de diplays ha utilizar
    Port(
    CE: in std_logic -- entrada de habilitacon procedente del timer
    clk: in std_logic; -- relog general
    RESET: in std_logic; -- reset general
    SEL: out std_logic_vector(N-1 downto 0)); -- salida de habilitacion de displays
end gen_secuencias;

architecture Behavioral of gen_secuencias is
    signal sel_in: std_logic_vector(N-1 downto 0):=(0=>'0',OTHERS=>'1'); -- registros internos para la salida de habiliatcion de los displays 
begin
    process(clk,RESET)
        begin
        if RESET = '1' then -- si se activa el reset general 
            sel_in <=(0=>'0',OTHERS=>'1'); -- habilita solo uno de los displays
        elsif rising_edge(clk) then -- cuando haya un flanco positivo de reloj
            if CE = '1' then -- se habilita el dispositivo
               sel_in <= sel_in(N-2 downto 0) & sel_in(N-1); -- rotacion de un bit hacia la izquierda
            end if;
        end if;
     end process;
     SEL <= sel_in; -- asignacion de la salida con la señal interna     
end Behavioral;
