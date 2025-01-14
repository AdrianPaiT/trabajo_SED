library IEEE;
use IEEE.Std_logic_1164.all;

entity fsm_tb is
end;

architecture bench of fsm_tb is

  -- Declaración del componente fsm
  component fsm 
    port ( 
      RESET      : in  std_logic; 
      CLK        : in  std_logic; 
      PUSHBUTTON : in  std_logic_vector(0 to 4); 
      LIGHT      : out std_logic_vector(0 TO 4)
    ); 
  end component;

  -- Señales para la simulación
  signal RESET     : std_logic := '0';  -- Inicialización de RESET
  signal CLK       : std_logic := '0';  -- Inicialización de CLK
  signal PUSHBUTTON : std_logic_vector(0 to 4) := "00000";  -- Inicialización de PUSHBUTTON
  signal LIGHT     : std_logic_vector(0 to 4);  -- Salida LIGHT
  
  -- Constantes y señales adicionales
  constant clock_period : time := 10 ns;

begin

  -- Instanciación del componente fsm
  uut: fsm port map (
    RESET      => RESET,
    CLK        => CLK,
    PUSHBUTTON => PUSHBUTTON,
    LIGHT      => LIGHT
  );

  -- Estímulo del testbench
  stimulus: process
  begin
    -- Inicialización
    RESET <= '1';  -- Inicializa RESET
    wait for clock_period * 2;  -- Esperamos dos ciclos de reloj para asegurar que el RESET se aplica correctamente
    RESET <= '0';  -- Desactivamos RESET

    -- Estímulos para la señal PUSHBUTTON (simulamos presionar los botones)
    PUSHBUTTON <= "00001";  -- Presionamos el botón 0
    wait for clock_period * 2;  -- Esperamos dos ciclos más para observar el cambio en la salida

    PUSHBUTTON <= "00010";  -- Presionamos el botón 1
    wait for clock_period * 2;

    PUSHBUTTON <= "00100";  -- Presionamos el botón 2
    wait for clock_period * 2;

    PUSHBUTTON <= "01000";  -- Presionamos el botón 3
    wait for clock_period * 2;

    PUSHBUTTON <= "10000";  -- Presionamos el botón 4
    wait for clock_period * 2;

    -- Esperar un poco más para que el sistema procese antes de finalizar
    wait for clock_period * 5;

    -- Finalización de la simulación
    wait;
  end process;

  -- Generación del reloj
  clocking: process
  begin
    -- Mantener el reloj generándose
    while true loop
      CLK <= '0', '1' after clock_period / 2;  -- Generación del ciclo de reloj
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

