library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
entity EDGEDTCTR is 
port (  
CLK      : in  std_logic; 
SYNC_IN  : in  std_logic_vector(4 downto 0); 
EDGE     : out std_logic 
); 
end EDGEDTCTR;
architecture BEHAVIORAL of EDGEDTCTR is 
signal sreg : std_logic_vector(2 downto 0); 
begin 
process (CLK) 
begin 
for i in 0 to 4 loop
if rising_edge(CLK) then 
sreg <= sreg(1 downto 0) & SYNC_IN(i); 
end if;
end loop; 
end process; 

with sreg select 
EDGE <= '1' when "100", 
'0' when others;
 
end BEHAVIORAL;
