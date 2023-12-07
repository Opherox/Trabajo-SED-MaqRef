----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2023 11:07:23
-- Design Name: 
-- Module Name: comparador - Behavioral
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

entity comparador is
Port(
    dinero_act: in integer;
    precio: in integer;
    clk: in std_logic;
    reset: in std_logic;
    falta_dinero: out std_logic;
    dinero_justo: out std_logic;
    sobra_dinero: out std_logic;
    diferencia: out integer);
end comparador;

architecture Behavioral of comparador is
signal resultado:integer;
begin
    process(clk,reset)
    begin
    if reset = '1' then --se puede añadir un CE en lugar del reset
        resultado <= precio;
        dinero_justo <= '0';
        falta_dinero <= '0';
        sobra_dinero <= '0';
    elsif rising_edge(clk) then
    resultado <= precio - dinero_act;
        if resultado = 0 then
            dinero_justo <= '1';
            falta_dinero <= '0';
            sobra_dinero <= '0';
        elsif resultado < 0 then
            dinero_justo <= '0';
            falta_dinero <= '0';
            sobra_dinero <= '1';
        elsif resultado > 0 then 
            dinero_justo <= '0';
            falta_dinero <= '1';
            sobra_dinero <= '0';
        end if;
    end if;
    end process;
diferencia <= resultado;
end Behavioral;
