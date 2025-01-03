library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity multinst_edge_tb is
end entity multinst_edge_tb;

architecture bench of multinst_edge_tb is

  -- Declaración del componente
  component multinst_edge
    port (  
      CLK     : in  std_logic; 
      SYNC_IN : in  std_logic_vector(4 downto 0); 
      EDGE    : out std_logic_vector(4 downto 0)
    ); 
  end component;

  -- Señales internas
  signal CLK     : std_logic := '0';
  signal SYNC_IN : std_logic_vector(4 downto 0) := (others => '0');
  signal EDGE    : std_logic_vector(4 downto 0);

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: multinst_edge
    port map (
      CLK     => CLK,
      SYNC_IN => SYNC_IN,
      EDGE    => EDGE
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
    SYNC_IN <= "00000";
    wait for 20 ns;

    -- Simulación de cambios en SYNC_IN
    SYNC_IN <= "10000";
    wait for 50 ns;

    SYNC_IN <= "01000";
    wait for 50 ns;

    SYNC_IN <= "00100";
    wait for 50 ns;

    SYNC_IN <= "00010";
    wait for 50 ns;

    SYNC_IN <= "00001";
    wait for 50 ns;

    -- Finalización de la simulación
    wait;
  end process;

end architecture bench;

-- Configuración de la simulación
configuration cfg_multinst_edge_tb of multinst_edge_tb is
  for bench
    for uut: multinst_edge
      use entity work.multinst_edge(Behavioral);
    end for;
  end for;
end cfg_multinst_edge_tb;
