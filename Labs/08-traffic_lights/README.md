library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity traffic is

port (clk: in STD_LOGIC;
		clr: in STD_LOGIC;
		lights: out STD_LOGIC_VECTOR(5 downto 0)
		);

end traffic;

--Behavioral

architecture traffic of traffic is

type state_type is (GR, YR, RR, RG, RY, RR2);

signal state: state_type;
signal Pocet: STD_LOGIC_VECTOR(3 downto 0);
constant sekund5: STD_LOGIC_VECTOR(3 downto 0) := "1111";
constant sekunda: STD_LOGIC_VECTOR(3 downto 0) := "0011";

begin

process(clk, clr)

	begin 
		if clr = '1' then
			state <= GR;
			Pocet <= X"0";
		elsif clk'event and clk = '1' then
			
		case state is 

		when GR => 								-- 1st Green 2nd Red
			if Pocet < sekund5 then 
				state <= GR;
				Pocet <= Pocet + 1;
			else
				state <= YR;
				Pocet <= X"0";
			end if;	
	
		when YR => 								-- 1st Yellow 2nd Red
			if Pocet < sekunda then 
				state <= YR;
				Pocet <= Pocet + 1;
			else
				state <= RR;
				Pocet <= X"0";
			end if;
		
		when RR => 								-- 1st Red 2nd Red
			if Pocet < sekunda then 
				state <= RR;
				Pocet <= Pocet + 1;
			else
				state <= RG;
				Pocet <= X"0";
			end if;
		
		when RG => 								-- 1st Red 2nd Green
			if Pocet < sekund5 then 
				state <= RG;
				Pocet <= Pocet + 1;
			else
				state <= RY;
				Pocet <= X"0";
			end if;

		when RY => 								-- 1st Red 2nd Yellow
			if Pocet < sekunda then 
				state <= RY;
				Pocet <= Pocet + 1;
			else
				state <= RR2;
				Pocet <= X"0";
			end if;
		
		when RR2 => 							-- 1st Red 2nd Red
			if Pocet < sekunda then 
				state <= RR2;
				Pocet <= Pocet + 1;
			else
				state <= GR;
				Pocet <= X"0";
			end if;	
	
		when others => 
				state <= GR;
		end case;
	end if;
end process;

C2: process(state)

	begin
		
		case state is 
			
			when GR => lights <= "100001";
			when YR => lights <= "100010";
			when RR => lights <= "100100";
			when RG => lights <= "001100";
			when RY => lights <= "010100";
			when RR2 => lights <= "100100";
			when others => lights <= "100001";		
		end case;
	end process;		
end traffic;

