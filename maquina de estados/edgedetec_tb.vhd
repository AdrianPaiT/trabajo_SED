library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EDGEDTCTR_tb is
end;

architecture bench of EDGEDTCTR_tb is

  component EDGEDTCTR 
  port (  
  CLK      : in  std_logic; 
  SYNC_IN  : in  std_logic; 
  EDGE     : out std_logic 
  ); 
  end component;

  signal CLK: std_logic;
  signal SYNC_IN: std_logic;
  signal EDGE: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: EDGEDTCTR port map ( CLK     => CLK,
                            SYNC_IN => SYNC_IN,
                            EDGE    => EDGE );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

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
