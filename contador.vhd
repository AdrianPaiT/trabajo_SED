library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    PORT (
        clk    : in  std_logic;                 -- Reloj de entrada
        button1 : in  std_logic;                -- Botón de incremento
        button2 : in  std_logic; 
        button3: in std_logic;               -- Botón de decremento
        button4: in std_logic; 
        button5: in std_logic; 
        reset  : in std_logic;     
        dig   : OUT std_logic_vector(3 downto 0) -- Control de los dígitos
    );
end counter;

architecture Behavioral of counter is
    signal s : unsigned(3 downto 0);  -- Contador de 4 bits (0-15)
    signal button1_d, button1_dd : std_logic; -- Señales para detectar flancos de button1
    signal button2_d, button2_dd : std_logic; -- Señales para detectar flancos de button2
    signal button3_d, button3_dd : std_logic;
    signal button4_d, button4_dd : std_logic;
    signal button5_d, button5_dd : std_logic;
begin

    -- Detección de flanco para button1 (incremento)
    process(clk, reset)
    begin
        if reset = '0' then
            button1_d <= '0';
            button1_dd <= '0';
        elsif rising_edge(clk) then
            button1_d <= button1;
            button1_dd <= button1_d;
        end if;
    end process;

    -- Detección de flanco para button2 (decremento)
    process(clk, reset)
    begin
        if reset = '0' then
            button2_d <= '0';
            button2_dd <= '0';
        elsif rising_edge(clk) then
            button2_d <= button2;
            button2_dd <= button2_d;
        end if;
    end process;
    
    process(clk, reset)
    begin
        if reset = '0' then
            button3_d <= '0';
            button3_dd <= '0';
        elsif rising_edge(clk) then
            button3_d <= button3;
            button3_dd <= button3_d;
        end if;
    end process;
    
     process(clk, reset)
    begin
        if reset = '0' then
            button4_d <= '0';
            button4_dd <= '0';
        elsif rising_edge(clk) then
            button4_d <= button4;
            button4_dd <= button4_d;
        end if;
    end process;
    
     process(clk, reset)
    begin
        if reset = '0' then
            button5_d <= '0';
            button5_dd <= '0';
        elsif rising_edge(clk) then
            button5_d <= button5;
            button5_dd <= button5_d;
        end if;
    end process;

    -- Lógica de contador con detección de flanco
    process(clk, reset)
    begin
        if reset = '0' then
            s <= (others => '0');  -- Resetear contador a 0
        elsif rising_edge(clk) then
            -- Lógica de incremento
            if (button1_d = '1' and button1_dd = '0') or (button3_d = '1' and button3_dd = '0') or (button4_d = '1' and button4_dd = '0') or (button5_d = '1' and button5_dd = '0') or (button2_d = '1' and button2_dd = '0') then
                if s = 4 then
                    s <= (others => '0');  -- Si alcanza 9, se reseteará a 0
                else
                    s <= s + 1;  -- Incrementar contador
                end if;
                          
            end if;
        end if;
    end process;

    dig <= not std_logic_vector(s);  -- Asignar el valor del contador a la salida

end Behavioral;
