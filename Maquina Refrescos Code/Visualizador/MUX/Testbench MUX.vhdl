library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX_TB is
end MUX_TB;

architecture TB_ARCH of MUX_TB is
  signal input_vector_tb: integer_vector(7 downto 0);
  signal SEL_tb: std_logic_vector(7 downto 0);
  signal output_tb: integer;
  
  component MUX
    Port(
      input_integer_vector: in integer_vector(7 downto 0);
      SEL: in std_logic_vector(7 downto 0);
      output_integer: out integer);
  end component;

begin
  -- Instantiate the MUX component
  UUT: MUX port map (input_integer_vector => input_vector_tb,
                     SEL => SEL_tb,
                     output_integer => output_tb);

  -- Stimulus process
  stimulus_process: process
  begin
    -- Test all possible combinations of SEL
    for i in 0 to 255 loop
      SEL_tb <= std_logic_vector(to_unsigned(i, SEL_tb'length));
      
      -- Assign some values to the input vector for testing
      for j in 0 to 7 loop
        input_vector_tb(j) <= j;  -- You can modify this based on your specific testing needs
      end loop;

      wait for 10 ns;  -- Adjust this delay as needed
    end loop;

    wait;  -- Wait indefinitely
  end process stimulus_process;

end TB_ARCH;
