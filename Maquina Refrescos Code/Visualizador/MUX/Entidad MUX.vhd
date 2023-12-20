library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
  Port(
  input_integer_vector: in integer_vector(7 downto 0); -- vector de enteros: un entero para cada display
  SEL: in std_logic_vector(7 downto 0); -- entrada de seleccion del mux
  output_integer: out integer); -- salida de un entero para los displays
end MUX;

architecture Behavioral of MUX is
signal salida: integer; -- variable interna para la salida
begin
     Process(SEL, input_integer_vector)
     begin
        case SEL is -- case para la asignacion de enteros al display correspondiente
        when "11111110" => salida<=input_integer_vector(0);
        when "11111101" => salida<=input_integer_vector(1);
        when "11111011" => salida<=input_integer_vector(2);
        when "11110111" => salida<=input_integer_vector(3);
        when "11101111" => salida<=input_integer_vector(4);
        when "11011111" => salida<=input_integer_vector(5);
        when "10111111" => salida<=input_integer_vector(6);
        when "01111111" => salida<=input_integer_vector(7);
        when others => salida<= input_integer_vector(0);
     end case;
     end process;
     output_integer <= salida; -- asignacion de la variable interna con la salida
end Behavioral;
