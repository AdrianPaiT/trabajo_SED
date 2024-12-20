library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
PORT (
    reset     : IN std_logic;                  -- Reset de la lógica
    clk       : IN std_logic;                  -- Reloj de entrada
    button    : IN std_logic_vector(4 downto 0); -- 5 botones de entrada (pero solo usamos 2)
    code      : IN std_logic_vector(3 downto 0); -- Código para el display (ej. 7 segmentos)
    digsel    : IN std_logic_vector(3 downto 0); -- Selección de digito
    digctrl   : OUT std_logic_vector(3 downto 0); -- Control de los dígitos
    segment   : OUT std_logic_vector(6 downto 0)  -- Display de segmentos
);
end top;

architecture Behavioral of top is
    signal sync_in : std_logic_vector(4 downto 0);  -- Sincronización de botones
    signal edge    : std_logic;                      -- Detección de flanco
    signal code_interm : std_logic_vector(3 downto 0); -- Salida del contador intermedio

    -- Declaración de los componentes
    COMPONENT decoder  
    PORT ( 
        code : IN std_logic_vector(3 downto 0); 
        led  : OUT std_logic_vector(6 downto 0) 
    ); 
    END COMPONENT; 

    COMPONENT SYNCHRNZR  
    PORT ( 
        CLK      : IN std_logic;
        ASYNC_IN : IN std_logic_vector(4 downto 0);
        SYNC_OUT : OUT std_logic_vector(4 downto 0)
    ); 
    END COMPONENT; 

    COMPONENT EDGEDTCTR is 
    PORT (  
        CLK      : IN std_logic; 
        SYNC_IN  : IN std_logic_vector(4 downto 0); 
        EDGE     : OUT std_logic
    ); 
    END COMPONENT;

    -- Instanciamos el contador modificado con botones 1 y 2
    COMPONENT counter is
        PORT (
            clk     : IN std_logic;              
            button1 : IN std_logic;               -- Botón 1
            button2 : IN std_logic;               -- Botón 2
            button3 : IN std_logic;
            button4 : IN std_logic;
            button5 : IN std_logic;
            reset   : IN std_logic;               -- Reset
            dig    : OUT std_logic_vector(3 downto 0) -- Código de salida
        );
    END COMPONENT;

begin

    -- Instancia del decodificador para el display
    Inst_decoder: decoder 
    PORT MAP ( 
        code => code_interm, 
        led  => segment 
    ); 

    -- Instancia del sincronizador para los botones
    Inst_SYNCHRNZR: SYNCHRNZR
    PORT MAP (
        ASYNC_IN => button,  -- Usamos el vector completo de botones
        CLK      => clk,
        SYNC_OUT => sync_in
    );

    -- Instancia del detector de flancos
    Inst_EDGEDTCTR: EDGEDTCTR
    PORT MAP (
        CLK      => clk,
        SYNC_IN  => sync_in,
        EDGE     => edge
    );

    -- Instancia del contador con botones 1 y 2
    Inst_counter: counter
    PORT MAP (
        clk     => clk,
        button1 => button(0),  -- Asignamos button(0) como button1
        button2 => button(1),  -- Asignamos button(1) como button2
        button3 => button(2),
        button4 => button(3),
        button5 => button(4),
        reset   => reset,
        dig  => digctrl
    );

    -- Control de los dígitos
--    digctrl <= NOT(digsel);

end Behavioral;

