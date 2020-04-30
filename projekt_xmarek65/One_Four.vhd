----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:09:42 04/15/2020 
-- Design Name: 
-- Module Name:    One_Four - Behavioral 
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

entity One_Four is
 port(
        -- Entity input signals
        a_i : in std_logic_vector(2-1 downto 0);    -- 2 address inputs

        -- Entity output signals
        y_o : out std_logic_vector(4-1 downto 0)    -- active-low outputs
    );

end One_Four;

architecture Behavioral of One_Four is

begin
 --  addr | outputs
    -- ------+---------
    --   0 0 | H H H L
    --   0 1 | H H L H
    --   1 0 | H L H H
    --   1 1 | L H H H
    y_o(0) <= a_i(0) or a_i(1); -- WRITE YOUR CODE HERE
    y_o(1) <= a_i(0) or (not a_i(1)); -- WRITE YOUR CODE HERE
    y_o(2) <= (not a_i(0)) or a_i(1); -- WRITE YOUR CODE HERE
    y_o(3) <= (not a_i(0)) or (not a_i(1)); -- WRITE YOUR CODE HERE


end Behavioral;