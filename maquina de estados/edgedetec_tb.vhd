library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EDGEDTCTR_tb is
end;

architecture bench of EDGEDTCTR_tb is

  component EDGEDTCTR 
  port (  
    CLK     : in  std_logic; 
    SYNC_IN : in  std_logic; 
    EDGE    : out std_logic 
  ); 
  end component;

  signal CLK: std_logic := '0';
  signal SYNC_IN: std_logic := '0';
  signal EDGE: std_logic;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean := false;

begin

  uut: EDGEDTCTR port map (
    CLK     => CLK,
    SYNC_IN => SYNC_IN,
    EDGE    => EDGE
  );

  stimulus: process
  begin
    -- Initialization
    SYNC_IN <= '0';
    wait for clock_period ;

    -- Test bench stimulus
    SYNC_IN <= '1';  -- Rising edge
    wait for clock_period ;

    assert EDGE = '1'
      report "ERROR: EDGE signal did not assert correctly after SYNC_IN rising edge."
      severity failure;

    SYNC_IN <= '0';  -- Falling edge
    wait for clock_period ;

    assert EDGE = '0'
      report "ERROR: EDGE signal did not deassert correctly after SYNC_IN falling edge."
      severity failure;

    -- Complete the simulation
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

