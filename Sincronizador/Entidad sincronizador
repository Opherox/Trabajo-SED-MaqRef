library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all; 

entity SYNCHRNZR is
  port (
    CLK : in STD_LOGIC;
    ASYNC_IN : in STD_LOGIC;
    SYNC_OUT : out STD_LOGIC
  );
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is
  constant SIZE: integer := 10000;
  signal sreg : std_logic_vector(1 downto 0) := "00";
  signal counter: integer range 0 to SIZE :=0; 
begin
  process (CLK)
  begin
    if rising_edge(CLK) then 
      counter <= counter + 1;
      if counter = SIZE-1 then
        counter <= 0;
        sreg <= sreg(0) & ASYNC_IN;
      end if;
    end if; 
  end process;
  SYNC_OUT <= sreg(1);
end Behavioral;
