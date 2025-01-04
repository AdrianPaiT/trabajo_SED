library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity decoder_tb is
end entity decoder_tb;

architecture bench of decoder_tb is

  -- Declaración del componente
  component decoder
    port (
      code : in  std_logic_vector(3 downto 0);
      led  : out std_logic_vector(6 downto 0)
    );
  end component;

  -- Señales internas
  signal code : std_logic_vector(3 downto 0) := (others => '0');
  signal led  : std_logic_vector(6 downto 0);

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: decoder
    port map (
      code => code,
      led  => led
    );

  -- Proceso de estímulos
  stimulus: process
  begin
    -- Prueba para cada código posible
    for i in 0 to 15 loop
      code <= std_logic_vector(to_unsigned(i, 4));
      wait for 10 ns;  -- Tiempo de espera entre estímulos
    end loop;

    -- Finalización de la simulación
    wait;
  end process;

end architecture bench;

-- Configuración para la simulación
configuration cfg_decoder_tb of decoder_tb is
  for bench
    for uut: decoder
      use entity work.decoder(dataflow);
    end for;
  end for;
end cfg_decoder_tb;
