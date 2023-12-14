----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2023 10:58:58
-- Design Name: 
-- Module Name: gen_secuencias - Behavioral
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
        begin
        if RESET = '1' then
            sel_in<=(0=>'0',OTHERS=>'1');
        elsif rising_edge(clk) then
            if CE = '1' then
                sel_in <= sel_in(N-2 downto 0) & sel_in(N-1);
            end if;
        end if;
     end process;
     SEL <= sel_in;
end Behavioral;
