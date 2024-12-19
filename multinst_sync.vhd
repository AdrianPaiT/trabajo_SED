----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2024 19:22:54
-- Design Name: 
-- Module Name: multinst_sync - Behavioral
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

entity multinst_sync is
port (  
CLK      : in  std_logic; 
ASYNC_IN : in  std_logic_vector(0 to 4); 
SYNC_OUT : out std_logic_vector(0 to 4)
); 
end multinst_sync;

architecture Behavioral of multinst_sync is
COMPONENT SYNCHRNZR  
PORT ( 
CLK:IN std_logic;
ASYNC_IN : in  std_logic;
SYNC_OUT : out std_logic
); 
END COMPONENT; 
begin
 multinst_sync: for i in 0 to 4 generate
Inst_SYNCHRNZR: SYNCHRNZR
PORT MAP(
ASYNC_IN=>ASYNC_IN(i),
CLK=>CLK,
SYNC_OUT=>SYNC_OUT(i)
);
end generate;

end Behavioral;
