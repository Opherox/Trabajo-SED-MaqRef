library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gestor_entradas is
  Port (
    boton10C: in std_logic;
    boton20C: in std_logic;
    boton50C: in std_logic;
    boton100C: in std_logic;
    clk: in std_logic;
    bot10C_S_E: out std_logic;
    bot20C_S_E: out std_logic;
    bot50C_S_E: out std_logic;
    bot100C_S_E: out std_logic);
end gestor_entradas;

architecture Estructural of gestor_entradas is

    component SYNCHRNZR is
    port (
        CLK : in STD_LOGIC;
        ASYNC_IN : in STD_LOGIC;
        SYNC_OUT : out STD_LOGIC);
    end component SYNCHRNZR;
    
    component EDGEDCTR is
    port ( 
        CLK : in STD_LOGIC;
        SYNC_IN : in STD_LOGIC;
        EDGE : out STD_LOGIC);
    end component EDGEDCTR;
    
    signal bot10C_S: std_logic;
    signal bot20C_S: std_logic;
    signal bot50C_S: std_logic;
    signal bot100C_S: std_logic;   
    
begin

--sincronizadores
    S1: SYNCHRNZR
    port map(
        CLK => clk,
        ASYNC_IN => boton10C,
        SYNC_OUT => bot10C_S);
    
    S2: SYNCHRNZR
    port map(
        CLK => clk,
        ASYNC_IN => boton20C,
        SYNC_OUT => bot20C_S);

    S3: SYNCHRNZR
    port map(
        CLK => clk,
        ASYNC_IN => boton50C,
        SYNC_OUT => bot50C_S);

    S4: SYNCHRNZR
    port map(
        CLK => clk,
        ASYNC_IN => boton100C,
        SYNC_OUT => bot100C_S);

--detectores de flancos        
    E1: EDGEDCTR
    port map(
        CLK => clk,
        SYNC_IN => bot10C_S,
        EDGE => bot10C_S_E);
        
    E2: EDGEDCTR
    port map(
        CLK => clk,
        SYNC_IN => bot20C_S,
        EDGE => bot20C_S_E);         
        
    E3: EDGEDCTR
    port map(
        CLK => clk,
        SYNC_IN => bot50C_S,
        EDGE => bot50C_S_E);         
        
    E4: EDGEDCTR
    port map(
        CLK => clk,
        SYNC_IN => bot100C_S,
        EDGE => bot100C_S_E);         
    
end Estructural;
