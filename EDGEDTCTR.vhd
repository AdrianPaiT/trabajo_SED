library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity EDGEDTCTR is 
    port (  
        CLK      : in  std_logic;              -- Reloj de entrada
        SYNC_IN  : in  std_logic_vector(4 downto 0); -- Entrada de botones
        EDGE     : out std_logic                -- Salida de flanco
    ); 
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is 
    signal sreg, sreg_d : std_logic_vector(4 downto 0); -- Registros para la señal SYNC_IN y su versión retardada
begin 

    process (CLK)
    begin
        if rising_edge(CLK) then
            sreg <= SYNC_IN;           -- Guardar el valor actual de SYNC_IN
            sreg_d <= sreg;            -- Guardar el valor anterior de SYNC_IN
        end if;
    end process; 

    -- Detectar flanco de subida
    process (sreg, sreg_d)
    begin
        if (sreg(0) = '1' and sreg_d(0) = '0') or 
           (sreg(1) = '1' and sreg_d(1) = '0') or 
           (sreg(2) = '1' and sreg_d(2) = '0') or 
           (sreg(3) = '1' and sreg_d(3) = '0') or 
           (sreg(4) = '1' and sreg_d(4) = '0') then
            EDGE <= '1'; -- Flanco de subida detectado en alguno de los botones
        else
            EDGE <= '0'; -- No hay flanco de subida
        end if;
    end process;

end BEHAVIORAL;
