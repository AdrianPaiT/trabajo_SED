library ieee;
use IEEE.STD_LOGIC_1164.ALL; 
entity fsm is 
port ( 
RESET      : in  std_logic; 
CLK        : in  std_logic; 
BUTTON : in  std_logic_vector(0 to 4); 
led      : out std_logic_vector(0 TO 3) 
); 
end fsm; 
architecture behavioral of fsm is 
type STATES is (S0, S1, S2, S3,S4, error); 
signal current_state: STATES := S0; 
signal next_state: STATES; 
begin 
state_register: process (RESET, CLK) 
begin 
if(RESET='0') then
current_state<=S0;
elsif rising_edge(CLK) then
current_state<=next_state;
end if;

end process; 
nextstate_decod: process (BUTTON, current_state) 
begin 
next_state <= current_state; 
case current_state is 
      when S0 => 
        if BUTTON(0) = '1' then       
           next_state <= S1;
        end if; 
      when S1 => 
        if BUTTON(1) = '1' then       
          next_state <= S2; 
        end if; 
      when S2 =>  
        if BUTTON(2) = '1' then       
          next_state <= S3; 
        end if; 
      when S3 =>  
        if BUTTON(3) = '1' then       
          next_state <= S4; 
        end if;
       when S4=>
          if BUTTON(4) = '1' then       
          next_state <= S0; 
        end if;
      when others => 
        next_state <= error; 
    end case; 
  end process; 
 
  output_decod: process (current_state) 
  begin 
    led <= (OTHERS => '0'); 
    case current_state is 
      when S0 => 
        led(0) <= '1'; 
      when S1 => 
        led(1) <= '1'; 
      when S2 =>  
        led(2) <= '1'; 
      when S3 =>  
        led(3) <= '1';
      when S4 =>  
        led(3) <= '1';  
      when error =>  
        led <= (OTHERS => '0'); 
    end case; 
  end process; 
end behavioral; 
