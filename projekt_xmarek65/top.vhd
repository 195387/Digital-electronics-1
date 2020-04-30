----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:48 04/19/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
	port( clk_i : in std_logic;
			trigr_i : in std_logic;
			
			
			echo_o : out std_logic;
			disp_sseg_o : out std_logic_vector(6 downto 0);
			disp_digit_o : out std_logic_vector(3 downto 0)
	
		 );

end top;

architecture Behavioral of top is

signal sw_seg : std_logic_vector(1 downto 0);
signal bjed : std_logic_vector(3 downto 0);
signal bdes : std_logic_vector(3 downto 0);
signal bsto : std_logic_vector(3 downto 0);
signal numb : std_logic_vector(3 downto 0);
signal start_i :std_logic;

begin
	
	gen10u: entity work.clk10u port map(
	
	clk => clk_i,
	
	out10u => start_i,
	clkseg => sw_seg	
	);
	
	pocitpuls: entity work.cntpulse port map(
	
	clk => clk_i,
	start => start_i,
	stop => trigr_i,
	
	bjed => bjed,
	bdes => bdes,
	bsto => bsto
	);
	
	onefour: entity work.One_Four port map(
	
	a_i => sw_seg,
	
	y_o => disp_digit_o
	);
	
	display: entity work.hex port map(
	
	hex_i => numb,
	
	sseg_o => disp_sseg_o
	);
	
	
	with sw_seg select
		numb <= bjed when "00",
				  bdes when "10",
				  bsto when "01",
				  "0000" when others;
				  
	echo_o <= start_i;			  
				  
end Behavioral;