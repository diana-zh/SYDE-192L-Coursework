library ieee;					
use ieee.std_logic_1164.all;	
use ieee.numeric_std.all;
-- use ieee.std_logic_unsigned.all;

entity Four_bit_adder is 	-- entity definition 
	port(	
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDG:		out 	std_logic_vector(9 downto 0));   -- Green switches
end entity Four_bit_adder; 

architecture main of Four_bit_adder is 
signal a, b:	unsigned(3 downto 0);	-- Naming inputs
signal c:	unsigned(4 downto 0);

begin 
a <= unsigned(SW(3 downto 0)); 
b <= unsigned(SW(9 downto 6));
c <= ('0' & a) + ('0' & b); -- addition syntax
LEDG(4 downto 0) <= std_logic_vector(c);

end architecture main; 
