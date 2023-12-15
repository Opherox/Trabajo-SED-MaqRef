library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decodificador is
Port (
    Numero : in integer;
    Segmentos : out std_logic_vector (6 downto 0)  
    );
end Decodificador;

architecture decodificador of Decodificador is

begin

with Numero select 
    Segmentos <= "0000001" when 0,
    "1001111" when 1,
    "0010010" when 2,
    "0000110" when 3,
    "1001100" when 4,
    "0100100" when 5,
    "0100000" when 6,
    "0001111" when 7,
    "0000000" when 8,
    "0000100" when 9,
    "0011000" when 25,  --una P (cambiarlo)
    "1111110" when 35,  --un -(cambiarlo)
    "1111110" when others; --tambien un - (cambiarlo)
    
end decodificador;
