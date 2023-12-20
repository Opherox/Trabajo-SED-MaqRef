library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity Timer is
 Port (
 Divider : in integer;
 clk : in std_logic;
 Reset : in std_logic; 
 clk_o : out std_logic 
 );
end Timer;

architecture Behavioral of Timer is

signal Counter : integer := Divider; 
signal clk_aux : std_logic := '0';
begin

clk_o_gen : process (clk, Reset)
    begin
    if Reset = '1' then
        clk_aux  <= '0';
        Counter <= Divider;
    elsif rising_edge (clk) then
        if Counter /= 0 then
            clk_aux <= '0';
            Counter <= Counter - 1;
        elsif Counter = 0 then
            clk_aux  <= '1';
            Counter <= Divider;
        end if;
    end if;
    clk_o <= clk_aux;      
end process;

end Behavioral;
