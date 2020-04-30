----------------------------------------------------------------------------------
-- Developers: Michal Marek, Václav Zahrádka 
-- 
-- Create Date:    09:25:25 04/30/2020  
--
-- Project Name: HC-SR04
-- Target Devices: CoolRunner-II CPLD starter board
-- Description: counter echo pulse and transform BIN to BCD code
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL; 

entity cntpulse is
    port( clk : in std_logic;	
          start : in std_logic;	--TRIGR
          stop : in std_logic;		--ECHO
          
            bjed :  out std_logic_vector(3 downto 0);	--bin_jednotky
            bdes :  out std_logic_vector(3 downto 0);	--bin_desitky			
            bsto :  out std_logic_vector(3 downto 0) 	--bin_stovky
        );

end cntpulse;

architecture Behavioral of cntpulse is
   
   signal cnttime : std_logic_vector(13 downto 0):= (Others => '0');	--delka pulzu ECHO  
   signal stopinside : std_logic := '0';								-- 1 -> citac cita   0 -> citac po resetu
   signal bcdconv : std_logic_vector(14 downto 0):= (Others => '0');	-- promenna prevodu 
   signal stobcdconv : std_logic_vector(2 downto 0):= (Others => '0');	-- pocet cyklu v prevodu  
   signal sepadd : std_logic_vector(1 downto 0):= (Others => '0');		--pomocna promena pro prevod 
   
   
begin
    pulse : process (clk)
        
    begin 
    
        if rising_edge(clk)  then																
            if stop = '1' then										-- zacatek scitani	 
				   cnttime <= cnttime + 1;																
				   stopinside <= '1';
					bjed <= bcdconv(8 downto 5);		--prirazeni jednotky
					bdes <= bcdconv(12 downto 9);		--prirazeni desitky
					bsto <= "00" & bcdconv(14 downto 13);	--prirazeni stovky
					
            elsif (start = '1' and stopinside = '1') then		--reset
					bcdconv <= "0000000" & cnttime(13 downto 6);	--vzdeleni casu 64 a nasledne prirazeni do promenne prevodu
               stopinside <= '0' ;
               cnttime <= (Others => '0');
				   stobcdconv <= (Others => '0');
            end if;
            if (stop = '1' and stobcdconv < "101") then										-- prepocet BIN to BCD 
                    if (bcdconv(8 downto 5) > 4 and sepadd(0) = '0') then				-- jednotky
                        bcdconv(8 downto 5) <= bcdconv(8 downto 5) + 3;
                        sepadd(0) <='1';
                    elsif (bcdconv(12 downto 9) > 4 and sepadd(1) = '0') then			-- desitky
                        bcdconv(12 downto 9) <= bcdconv(12 downto 9) + 3;
                        sepadd(1) <='1';
                    else     
                        bcdconv <= bcdconv(13 downto 0) & '0';							   -- posunuti doleva
                        stobcdconv <= stobcdconv +1;
                        sepadd <="00";
                    end if;  
            end if;
        end if; 
        
    end process pulse;
	 
        

end Behavioral;