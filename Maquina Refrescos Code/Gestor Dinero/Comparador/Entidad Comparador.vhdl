library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparador is
Port(
    dinero_act: in integer;
    Precio: in integer;
    clk: in std_logic;
    reset: in std_logic;
    Reset_D : in std_logic;
    falta_dinero: out std_logic;
    dinero_justo: out std_logic;
    sobra_dinero: out std_logic);
end comparador;

architecture Behavioral of comparador is

--signal resultado : integer := Precio;

begin

    process(clk,reset,Reset_D)
    
    variable resultado : integer := Precio;
    
    begin
    
    if reset = '1' or Reset_D = '1' then --se puede añadir un CE en lugar del reset
        resultado := Precio;
        dinero_justo <= '0';
        falta_dinero <= '0';
        sobra_dinero <= '0';
    elsif rising_edge(clk) then
        resultado := precio - dinero_act;
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
    
end Behavioral;
