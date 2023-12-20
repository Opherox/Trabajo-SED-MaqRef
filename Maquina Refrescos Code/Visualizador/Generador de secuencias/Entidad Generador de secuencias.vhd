library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gen_secuencias iS
    Generic(N:Positive:=8);
    Port(
    CE: in std_logic;
    clk: in std_logic;
    RESET: in std_logic;
    SEL: out std_logic_vector(N-1 downto 0));
end gen_secuencias;

architecture Behavioral of gen_secuencias is

    signal sel_in: std_logic_vector(N-1 downto 0):=(0=>'0',OTHERS=>'1');
    
begin
    
    process(clk,RESET)
    --variable i : integer := 0;
        begin
        if RESET = '1' then
            sel_in <=(0=>'0',OTHERS=>'1'); --elemento 0 del vector a 0, el resto a 1
            --i := 0;
        elsif rising_edge(clk) then
            if CE = '1' then --si se habilita el cambio
                --i := i+1;
                --if i > N-1 then --i mayor que N-1 empezar la secuencia de 0
                    --i := 0;
                --end if;
                --for j in 0 to N-1 loop  -- como es logica negada el elemento a seleccionar a 0 el resto a 1
                    --if (i=j) then
                    --sel_in(j) <= '0';
                    --else
                    --sel_in(j) <= '1';
                    --end if;
                --end loop; 
               sel_in <= sel_in(N-2 downto 0) & sel_in(N-1);
            end if;
        end if;
     end process;
     SEL <= sel_in;
     
end Behavioral;
