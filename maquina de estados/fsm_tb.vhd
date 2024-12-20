library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fsm_tb is
end;

architecture bench of fsm_tb is

  component fsm 
  port ( 
  RESET      : in  std_logic; 
  CLK        : in  std_logic; 
  BUTTON : in  std_logic_vector(0 to 4); 
  switch: in std_logic;
  led      : out std_logic_vector(0 TO 4); 
  led_error: out std_logic 
  ); 
  end component;

  signal RESET: std_logic;
  signal CLK: std_logic;
  signal BUTTON: std_logic_vector(0 to 4);
  signal switch: std_logic;
  signal led: std_logic_vector(0 TO 4);
  signal led_error: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: fsm port map ( RESET     => RESET,
                      CLK       => CLK,
                      BUTTON    => BUTTON,
                      switch    => switch,
                      led       => led,
                      led_error => led_error );

  stimulus: process
  begin
  
   
    BUTTON <= "10000";
    wait for clock_period;
  
    BUTTON <= "01000";
    wait for clock_period;
   
    BUTTON <= "00100";
    wait for clock_period;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
