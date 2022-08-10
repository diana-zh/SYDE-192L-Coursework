library ieee;
use ieee.std_logic_1164.all;


entity lab_3_4_1 is 	-- entity definition 
	port( 
			SW: 		in 	std_logic_vector(3 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(1 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(1 downto 0)		-- Green LEDs 
			); 
end entity lab_3_4_1; 

architecture main of lab_3_4_1 is 
signal a, b, x, y:	std_logic;	-- Naming inputs 
signal enable, direction: 		std_logic;	-- AND gate output for reading by XOR gate  

begin 
a <= SW(3); 
b <= SW(2); 
x <= SW(1); 
y <= SW(0);  

enable <= (a and not(x) and y) or (a and not(b) and y) or (not(a) and b and x) or (b and x and not(y));
direction <= (a and not(b) and x and y) or (not(a) and b and x);

LEDR(0) <= enable; 
LEDG(0) <= direction;
end architecture main; 
