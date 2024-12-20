library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
--  Port ( );
PORT (
reset:IN std_logic;
CLK:IN std_logic;
button: IN std_logic_vector(0 to 4);
led : OUT std_logic_vector(0 to 4) 
);
end top;

architecture Behavioral of top is
signal syn_edg: std_logic_vector(0 to 4);
signal edge_fsm: std_logic_vector(0 to 4);


COMPONENT multinst_sync  
port (  
CLK      : in  std_logic; 
ASYNC_IN : in  std_logic_vector(0 to 4); 
SYNC_OUT : out std_logic_vector(0 to 4)
); 
END COMPONENT; 

COMPONENT multinst_edge is 
port (  
CLK      : in  std_logic; 
SYNC_IN  : in  std_logic_vector(0 to 4); 
EDGE     : out std_logic_vector(0 to 4)
); 
end COMPONENT;

COMPONENT fsm is 
port ( 
RESET      : in  std_logic; 
CLK        : in  std_logic; 
PUSHBUTTON : in  std_logic_vector(0 to 4); 
LIGHT      : out std_logic_vector(0 TO 4)
); 
end COMPONENT;

begin
Inst_multinst_sync: multinst_sync
PORT MAP(
ASYNC_IN=>button,
CLK=>clk,
SYNC_OUT=>syn_edg
);
Inst_multi_edge: multinst_edge
PORT MAP(
CLK=>clk,
SYNC_IN=>syn_edg,
EDGE=>edge_fsm
);
Inst_fsm:fsm
PORT MAP(
RESET=>reset,
CLK=>clk,
PUSHBUTTON=>edge_fsm,
LIGHT=>led
);

end behavioral;
