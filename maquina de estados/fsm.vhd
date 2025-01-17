library ieee;
use IEEE.STD_LOGIC_1164.ALL; 
entity fsm is 
port ( 
RESET      : in  std_logic; 
CLK        : in  std_logic; 
PUSHBUTTON : in  std_logic_vector(0 to 4); 
--switch: in std_logic;
LIGHT      : out std_logic_vector(0 TO 4)
--led_error: out std_logic:='0'
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
nextstate_decod: process (PUSHBUTTON, current_state) 
begin 
next_state <= current_state; 
case current_state is 
      when S0 => 
        if PUSHBUTTON(0) = '1' then       
           next_state <= S1;
           elsif PUSHBUTTON(1) = '1' or PUSHBUTTON(2)='1' or PUSHBUTTON(3)='1'or PUSHBUTTON(4)='1' then 
           next_state<= error;
        end if; 
      when S1 => 
        if PUSHBUTTON(1) = '1' then       
          next_state <= S2; 
           elsif PUSHBUTTON(0)='1' or PUSHBUTTON(2)='1'or PUSHBUTTON(3)='1'or PUSHBUTTON(4)='1' then    
           next_state<= error;
        end if; 
      when S2 =>  
        if PUSHBUTTON(2) = '1' then       
          next_state <= S3; 
            elsif PUSHBUTTON(0)='1' or PUSHBUTTON(1)='1'or PUSHBUTTON(3)='1'or PUSHBUTTON(4)='1' then    
           next_state<= error;
        end if; 
      when S3 =>  
        if PUSHBUTTON(3) = '1' then       
          next_state <= S4;
            elsif PUSHBUTTON(0)='1'or PUSHBUTTON(1)='1'or PUSHBUTTON(2)='1'or PUSHBUTTON(4)='1' then     
           next_state<= error;
        end if;
       when S4=>
          if PUSHBUTTON(4) = '1' then       
          next_state <= S0; 
           elsif PUSHBUTTON(0)='1'or PUSHBUTTON(1)='1'or PUSHBUTTON(2)='1'or PUSHBUTTON(3)='1'  then   
           next_state<= error;
        end if;
        when others=>
          next_state<= error;
     -- when error => 
          --if switch='1' then
         -- next_state<=S0;
          --end if;
         
    end case; 
  end process; 
 
  output_decod: process (current_state) 
  begin 
    LIGHT <= (OTHERS => '0'); 
    case current_state is 
      when S0 => 
        LIGHT(0) <= '1'; 
      when S1 => 
        LIGHT(1) <= '1'; 
      when S2 =>  
        LIGHT(2) <= '1'; 
      when S3 =>  
        LIGHT(3) <= '1';
      when S4 =>  
        LIGHT(4) <= '1';  
      when error =>  
        LIGHT <= (OTHERS => '0');
    end case;
    end process;
    end behavioral; 
