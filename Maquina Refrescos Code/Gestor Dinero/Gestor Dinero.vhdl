----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2023 17:49:38
-- Design Name: 
-- Module Name: gestor_de_dinero - Behavioral
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

entity Gestor_Dinero is
    Port(
        cent10:in std_logic;
        cent20:in std_logic;
        cent50:in std_logic;
        cent100:in std_logic;
        clk:in std_logic;
        reset:in std_logic;
        precio: in integer;
        falta_dinero:out std_logic;
        sobra_dinero:out std_logic;
        dinero_justo:out std_logic;
        diferencia : out integer);
end Gestor_Dinero;

architecture Estructural of Gestor_Dinero is
    
    component comparador is
        Port(
        dinero_act: in integer;
        precio: in integer;
        clk: in std_logic;
        reset: in std_logic;
        falta_dinero: out std_logic;
        dinero_justo: out std_logic;
        sobra_dinero: out std_logic;
        diferencia: out integer);
     end component;
     
     component contador is
        Port(
        cent10: in std_logic;
        cent20: in std_logic;
        cent50: in std_logic;
        cent100: in std_logic;
        reset: in std_logic;
        clk: in std_logic;
        dinero: out integer); 
     end component;
     
    signal dinero_actual:integer; 
begin

 cont: contador
    Port map(
    cent10=>cent10,
    cent20=>cent20,
    cent50=>cent50,
    cent100=>cent100,
    reset=>reset,
    clk=>clk,
    dinero=>dinero_actual);
    
 comp: comparador
    Port map(
    dinero_act=>dinero_actual,
    precio=>precio,
    clk=>clk,
    reset=>reset,
    falta_dinero=>falta_dinero,
    dinero_justo=>dinero_justo,
    sobra_dinero=>sobra_dinero,
    diferencia=>diferencia);
    
end Estructural;
