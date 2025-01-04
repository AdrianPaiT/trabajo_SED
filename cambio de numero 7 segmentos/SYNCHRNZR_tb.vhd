library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity SYNCHRNZR_tb is
end entity SYNCHRNZR_tb;

architecture bench of SYNCHRNZR_tb is

  -- Declaración del componente
  component SYNCHRNZR
    port (  
      CLK      : in  std_logic; 
      ASYNC_IN : in  std_logic_vector(4 downto 0); 
      SYNC_OUT : out std_logic_vector(4 downto 0)
    ); 
  end component;

  -- Señales internas
  signal CLK      : std_logic := '0';
  signal ASYNC_IN : std_logic_vector(4 downto 0) := (others => '0');
  signal SYNC_OUT : std_logic_vector(4 downto 0);

  -- Constantes
  constant clock_period : time := 10 ns;

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: SYNCHRNZR
    port map (
      CLK      => CLK,
      ASYNC_IN => ASYNC_IN,
      SYNC_OUT => SYNC_OUT
    );

  -- Generador de reloj
  clocking: process
  begin
    while true loop
      CLK <= '0';
      wait for clock_period / 2;
      CLK <= '1';
      wait for clock_period / 2;
    end loop;
  end process;

  -- Proceso de estímulos
  stimulus: process
  begin
    -- Inicialización
    ASYNC_IN <= "00000";
    wait for 20 ns;

    -- Simulación de entradas asincrónicas
    ASYNC_IN <= "00001";
    wait for 15 ns;

    ASYNC_IN <= "00010";
    wait for 25 ns;

    ASYNC_IN <= "00100";
    wait for 20 ns;

    ASYNC_IN <= "01000";
    wait for 20 ns;

    ASYNC_IN <= "10000";
    wait for 20 ns;

    -- Finalización de la simulación
    wait;
  end process;

end architecture bench;

-- Configuración de la simulación
configuration cfg_SYNCHRNZR_tb of SYNCHRNZR_tb is
  for bench
    for uut: SYNCHRNZR
      use entity work.SYNCHRNZR(BEHAVIORAL);
    end for;
  end for;
end cfg_SYNCHRNZR_tb;
