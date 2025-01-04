library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EDGEDTCTR_tb is
end entity EDGEDTCTR_tb;

architecture bench of EDGEDTCTR_tb is

  -- Declaración del componente
  component EDGEDTCTR
    port (  
      CLK      : in  std_logic;
      SYNC_IN  : in  std_logic_vector(4 downto 0);
      EDGE     : out std_logic
    ); 
  end component;

  -- Señales internas
  signal CLK      : std_logic := '0';
  signal SYNC_IN  : std_logic_vector(4 downto 0) := (others => '0');
  signal EDGE     : std_logic;

  -- Constantes
  constant clock_period : time := 10 ns;

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: EDGEDTCTR
    port map (
      CLK     => CLK,
      SYNC_IN => SYNC_IN,
      EDGE    => EDGE
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
    SYNC_IN <= "00000";
    wait for 20 ns;

    -- Cambios en SYNC_IN para detectar flancos
    SYNC_IN <= "00001";
    wait for 20 ns;

    SYNC_IN <= "00010";
    wait for 20 ns;

    SYNC_IN <= "00100";
    wait for 20 ns;

    SYNC_IN <= "01000";
    wait for 20 ns;

    SYNC_IN <= "10000";
    wait for 20 ns;

    -- Finalización de la simulación
    wait;
  end process;

end architecture bench;

-- Configuración de la simulación
configuration cfg_EDGEDTCTR_tb of EDGEDTCTR_tb is
  for bench
    for uut: EDGEDTCTR
      use entity work.EDGEDTCTR(BEHAVIORAL);
    end for;
  end for;
end cfg_EDGEDTCTR_tb;
