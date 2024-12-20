----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2024 19:00:15
-- Design Name: 
-- Module Name: multinst_edge - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multinst_edge is
port (  
CLK      : in  std_logic; 
SYNC_IN  : in  std_logic_vector(0 to 4); 
EDGE     : out std_logic_vector(0 to 4)
); 
end multinst_edge;

architecture Behavioral of multinst_edge is

COMPONENT EDGEDTCTR is 
port (  
CLK      : in  std_logic; 
SYNC_IN  : in  std_logic; 
EDGE     : out std_logic 
); 
end COMPONENT;

begin
 multinst_edge: for i in 0 to 4 generate
Inst_EDGEDTCTR: EDGEDTCTR
PORT MAP(
CLK=>CLK,
SYNC_IN=>SYNC_IN(i),
EDGE=>EDGE(i)
);
end generate;

end Behavioral;
