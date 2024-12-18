library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
entity SYNCHRNZR is 
port (  
CLK      : in  std_logic; 
ASYNC_IN : in  std_logic_vector(4 downto 0); 
SYNC_OUT : out std_logic_vector(4 downto 0) 
); 
end SYNCHRNZR; 
architecture BEHAVIORAL of SYNCHRNZR is 
signal sreg : std_logic_vector(1 downto 0); 
begin 
process (CLK) 
begin 
for i in 0 to 4 loop
if rising_edge(CLK) then   
sync_out(i) <= sreg(1); 
sreg <= sreg(0) & async_in(i); 
end if; 
end loop;
end process; 
end BEHAVIORAL; 
