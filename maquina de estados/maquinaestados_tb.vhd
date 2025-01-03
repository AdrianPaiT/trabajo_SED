library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity top_tb is
end;

architecture bench of top_tb is

  -- Declaración del componente
  component top
    port (
      reset : in std_logic;
      CLK   : in std_logic;
      button: in std_logic_vector(0 to 4);
      led   : out std_logic_vector(0 to 4)
    );
  end component;

  -- Señales internas
  signal reset : std_logic := '0';
  signal CLK   : std_logic := '0';
  signal button: std_logic_vector(0 to 4) := (others => '0');
  signal led   : std_logic_vector(0 to 4);

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: top
    port map (
      reset  => reset,
      CLK    => CLK,
      button => button,
      led    => led
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
    reset <= '1';
    wait for 20 ns;
    reset <= '0';

    -- Simulación de pulsaciones de botón
    button <= "10000";
    wait for 50 ns;

    button <= "01000";
    wait for 50 ns;

    button <= "00100";
    wait for 50 ns;

    button <= "00010";
    wait for 50 ns;

    button <= "00001";
    wait for 50 ns;

    -- Finalización de la simulación
    wait;
  end process;

end bench;

-- Configuración de la simulación
configuration cfg_top_tb_Behavioral of top_tb is
  for bench
    for uut: top
      use entity work.top(Behavioral);
    end for;
  end for;
end cfg_top_tb_Behavioral;

