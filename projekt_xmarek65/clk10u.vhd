----------------------------------------------------------------------------------
-- Developers: Michal Marek, Václav Zahrádka 
-- 
-- Create Date:    09:25:25 04/30/2020  
--
-- Project Name: HC-SR04
-- Target Devices: CoolRunner-II CPLD starter board
-- Description: generate TRIGER pulse and 17bit bin counter
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;



entity clk10u is

    port( clk : in std_logic;
          out10u : out std_logic;		--output 10us puls
		  clkseg : out std_logic_vector(1 downto 0)	--hodinovy signal do prepinace 7seg
        );
end clk10u;

architecture Behavioral of clk10u is
signal countbin : std_logic_vector(16 downto 0):= (Others => '0') ;	--17bit casovac
signal cntout : std_logic_vector(3 downto 0):= (Others => '0') ;	--pocitadlo 10u
signal outnext : std_logic:=  '0';	
signal mem: std_logic_vector(1 downto 0):= (Others => '0') ;	--pamet minuleho stavu

begin
    bincnt : process(clk)
    begin 
        if rising_edge(clk) then	--casovac (bin scitacka)
            countbin <= countbin + 1;
        end if;    
    end process bincnt;
               
    
    outsigcnt : process(clk) 
        begin          
            if rising_edge(clk)  then	--pocitadlo 10u pulzu
                mem <= (mem(0) & countbin(16));	--posun pameti
                if mem = "01" then		--reset pocitaci promene, kdyz je vzestupna hrana casovace 
 
                    cntout <= "0000";
                end if;
                if cntout = "1010" then	--zastaveni pocitani pulzu a out -> '0'
                    out10u <= '0';

                   
                else		--pocitani a out -> '1'
                    cntout <= cntout + 1; 
                    out10u <= '1';
                end if;                
            end if;    
            
        end process outsigcnt;
      clkseg <= countbin(13 downto 12);	--hodinovy signal do prepinace 7seg

	  
end Behavioral;