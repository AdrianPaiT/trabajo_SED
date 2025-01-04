library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity top_tb is
end entity top_tb;

architecture bench of top_tb is

  -- Declaración del componente
  component top
    port (
      reset     : in  std_logic;
      clk       : in  std_logic;
      button    : in  std_logic_vector(4 downto 0);
      code      : in  std_logic_vector(3 downto 0);
      digsel    : in  std_logic_vector(3 downto 0);
      digctrl   : out std_logic_vector(3 downto 0);
      segment   : out std_logic_vector(6 downto 0)
    );
  end component;

  -- Señales internas
  signal reset   : std_logic := '0';
  signal clk     : std_logic := '0';
  signal button  : std_logic_vector(4 downto 0) := (others => '0');
  signal code    : std_logic_vector(3 downto 0) := (others => '0');
  signal digsel  : std_logic_vector(3 downto 0) := (others => '0');
  signal digctrl : std_logic_vector(3 downto 0);
  signal segment : std_logic_vector(6 downto 0);

  constant clock_period : time := 10 ns;

begin

  -- Instancia de la unidad bajo prueba (UUT)
  uut: top
    port map (
      reset   => reset,
      clk     => clk,
      button  => button,
      code    => code,
      digsel  => digsel,
      digctrl => digctrl,
      segment => segment
    );

  -- Generador de estímulos
  stimulus: process
  begin
    -- Inicialización
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    
    -- Pruebas de botones
    button <= "00001";
    wait for 20 ns;
    button <= "00010";
    wait for 20 ns;
    button <= "00100";
    wait for 20 ns;
    button <= "01000";
    wait for 20 ns;
    button <= "10000";
    wait for 20 ns;

    -- Prueba de código y selección de dígito
    code <= "0101";
    digsel <= "0010";
    wait for 40 ns;

    -- Final de la simulación
    wait;
  end process;

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

end architecture bench;

-- Configuración de la simulación
configuration cfg_top_tb of top_tb is
  for bench
    for uut: top
      use entity work.top(Behavioral);
    end for;
  end for;
end cfg_top_tb;
