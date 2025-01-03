library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity multinst_sync_tb is
end entity multinst_sync_tb;

architecture bench of multinst_sync_tb is

  -- Declaración del componente
  component multinst_sync
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

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: multinst_sync
    port map (
      CLK      => CLK,
      ASYNC_IN => ASYNC_IN,
      SYNC_OUT => SYNC_OUT
    );

  -- Generador de reloj
  clk_gen: process
  begin
    while true loop
      CLK <= '0';
      wait for 10 ns;
      CLK <= '1';
      wait for 10 ns;
    end loop;
  end process;

  -- Proceso de estímulos
  stimulus: process
  begin
    -- Inicialización
    ASYNC_IN <= "00000";
    wait for 20 ns;

    -- Simulación de cambios en ASYNC_IN
    ASYNC_IN <= "10000";
    wait for 50 ns;

    ASYNC_IN <= "01000";
    wait for 50 ns;

    ASYNC_IN <= "00100";
    wait for 50 ns;

    ASYNC_IN <= "00010";
    wait for 50 ns;

    ASYNC_IN <= "00001";
    wait for 50 ns;

    -- Finalización de la simulación
    wait;
  end process;

end architecture bench;

-- Configuración de la simulación
configuration cfg_multinst_sync_tb of multinst_sync_tb is
  for bench
    for uut: multinst_sync
      use entity work.multinst_sync(Behavioral);
    end for;
  end for;
end cfg_multinst_sync_tb;
