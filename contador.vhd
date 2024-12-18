library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity counter is
    PORT (
        clk  : in  std_logic;                      
        CE   : in  std_logic;         
        reset: in std_logic;             
        code : out std_logic_vector(3 downto 0)    
        
    );
end counter;

architecture Behavioral of counter is
    signal s : unsigned(code'range) ; 
begin
    process(clk,reset)
       
                 
    begin
    if reset = '0' then
    s<=(others=>'0');
        elsif rising_edge(clk) then                      
            if CE = '1' then                          
              
                    s <= s + 1;       
                end if;
                
            end if;
        
    end process;

    code <= std_logic_vector(s);                                    
end Behavioral;