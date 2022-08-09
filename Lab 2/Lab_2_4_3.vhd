library ieee;
use ieee.std_logic_1164.all;

entity Lab_2_4_3 is 	-- entity definition 
	port( KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(3 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0)		-- Green LEDs 
			); 
end entity Lab_2_4_3; 

architecture main of Lab_2_4_3 is 
signal a1, a0, b1, b0:	std_logic;	-- Naming inputs 
signal c0, c1, c2: 				std_logic;	-- AND gate output for reading by XOR gate  

begin 
a1 <= SW(1); 
a0 <= SW(0); 
b1 <= SW(3); 
b0 <= SW(2);  


c0 <= 
(not(a1) and not(a0) and not(b1) and b0) or 
(not(a1) and not(a0) and b1 and b0) or
(not(a1) and a0 and not(b1) and not(b0)) or 
(not(a1) and a0 and b1 and not(b0)) or
(a1 and not(a0) and not(b1) and b0) or 
(a1 and not(a0) and b1 and b0) or
(a1 and a0 and not(b1) and not(b0)) or 
(a1 and a0 and b1 and not(b0));


c1 <=
(not(a1) and not(a0) and b1 and not(b0)) or 
(not(a1) and not(a0) and b1 and b0) or
(not(a1) and a0 and not(b1) and b0) or 
(not(a1) and a0 and b1 and not(b0)) or
(a1 and not(a0) and not(b1) and not(b0)) or 
(a1 and not(a0) and not(b1) and b0) or
(a1 and a0 and not(b1) and not(b0)) or 
(a1 and a0 and b1 and b0);

c2 <=
(not(a1) and a0 and b1 and b0) or 
(a1 and not(a0) and b1 and not(b0)) or
(a1 and not(a0) and b1 and b0) or 
(a1 and a0 and not(b1) and b0) or
(a1 and a0 and b1 and not(b0)) or 
(a1 and a0 and b1 and b0);

LEDR(0) <= c0; 
LEDR(1) <= c1; 
LEDR(2) <= c2; 
end architecture main; 
			
