----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2023 10:19:59
-- Design Name: 
-- Module Name: mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
  Port(
  input_integer_vector: in integer_vector(7 downto 0);
  SEL: in std_logic_vector(7 downto 0);
  output_integer: out integer);
end MUX;

architecture Behavioral of MUX is
signal salida: integer;
begin
     Process(SEL, input_integer_vector)
     begin
        case SEL is
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
     output_integer <= salida;
end Behavioral;
