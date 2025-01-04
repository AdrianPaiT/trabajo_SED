library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity counter_tb is
end entity counter_tb;

architecture bench of counter_tb is

  -- Declaración del componente
  component counter
    port (
      clk     : in  std_logic;
      button1 : in  std_logic;
      button2 : in  std_logic;
      button3 : in  std_logic;
      button4 : in  std_logic;
      button5 : in  std_logic;
      reset   : in  std_logic;
      dig     : out std_logic_vector(3 downto 0)
    );
  end component;

  -- Señales internas
  signal clk      : std_logic := '0';
  signal button1  : std_logic := '0';
  signal button2  : std_logic := '0';
  signal button3  : std_logic := '0';
  signal button4  : std_logic := '0';
  signal button5  : std_logic := '0';
  signal reset    : std_logic := '0';
  signal dig      : std_logic_vector(3 downto 0);

  -- Constantes
  constant clock_period : time := 10 ns;

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: counter
    port map (
      clk     => clk,
      button1 => button1,
      button2 => button2,
      button3 => button3,
      button4 => button4,
      button5 => button5,
      reset   => reset,
      dig     => dig
    );

  -- Generador de reloj
  clocking: process
  begin
    while true loop
      clk <= '0';
      wait for clock_period / 2;
      clk <= '1';
      wait for clock_period / 2;
    end loop;
  end process;

  -- Proceso de estímulos
  stimulus: process
  begin
    -- Inicialización del reset
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 20 ns;

    -- Estímulos para los botones
    button1 <= '1';
    wait for 30 ns;
    button1 <= '0';

    button2 <= '1';
    wait for 30 ns;
    button2 <= '0';

    button3 <= '1';
    wait for 30 ns;
    button3 <= '0';

    button4 <= '1';
    wait for 30 ns;
    button4 <= '0';

    button5 <= '1';
    wait for 30 ns;
    button5 <= '0';

    -- Finalización de la simulación
    wait;
  end process;

end architecture bench;

-- Configuración para la simulación
configuration cfg_counter_tb of counter_tb is
  for bench
    for uut: counter
      use entity work.counter(Behavioral);
    end for;
  end for;
end cfg_counter_tb;
