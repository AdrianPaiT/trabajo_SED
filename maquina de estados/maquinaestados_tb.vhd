library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity top_tb is
end;

architecture bench of top_tb is

  component top
  PORT (
  reset:IN std_logic;
  CLK:IN std_logic;
  button: IN std_logic_vector(0 to 4);
  led : OUT std_logic_vector(0 to 4) 
  );
  end component;

  signal reset: std_logic;
  signal CLK: std_logic;
  signal button: std_logic_vector(0 to 4);
  signal led: std_logic_vector(0 to 4) ;

begin

  uut: top port map ( reset  => reset,
                      CLK    => CLK,
                      button => button,
                      led    => led );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;
  
--Configuration Declaration

configuration cfg_top_tb of top_tb is
  for bench
    for uut: top
      -- Default configuration
    end for;
  end for;
end cfg_top_tb;

configuration cfg_top_tb_Behavioral of top_tb is
  for bench
    for uut: top
      use entity work.top(Behavioral);
    end for;
  end for;
end cfg_top_tb_Behavioral;
