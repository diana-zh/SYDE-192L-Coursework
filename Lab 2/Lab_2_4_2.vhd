-- It implements three primitive gates of AND, OR, and NOT (inverter) 

library ieee;
use ieee.std_logic_1164.all;


entity Lab_2_4_2 is 	-- entity definition 
	port( KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(3 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(3 downto 0)	-- Green LEDs 
			); 
end entity Lab_2_4_2; 

architecture main of Lab_2_4_2 is 
signal a0, a1, b1, b0:	std_logic;	-- Naming inputs 
signal p0: 		std_logic;	-- Naming outputs
signal p1: 		std_logic;
signal p2: 		std_logic;
signal p3: 		std_logic;			

begin 
a1 <= SW(0); 
a0 <= SW(1); 
b1 <= SW(2); 
b0 <= SW(3); 
 
p3 <= (a1 and b1)and (a0 and b0);
p2 <= not(a0 and b0) and (a1 and b1);
p1 <= ((a0 and b1) and not(b0 and a1)) or (not(a0 and b1) and (b0 and a1));
p0 <= a0 and b0;

LEDR(0) <= p0; 
LEDR(1) <= p1; 
LEDR(2) <= p2;
LEDR(3) <= p3; 
end architecture main; 
