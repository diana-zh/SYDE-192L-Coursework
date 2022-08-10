
library ieee;					
use ieee.std_logic_1164.all;	
-- use ieee.numeric_std.all;

entity lab_3_4_2 is 	-- entity definition 
	port(	SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDG:		out 	std_logic_vector(9 downto 0));   -- Red switches
end entity; 

architecture RTL of lab_3_4_2 is 
signal x0, y0, x1, y1, x2, y2, x3, y3:	std_logic;	-- Naming inputs
signal cout1, cout2, cout3, cout4: std_logic; 
signal s0, s1, s2, s3: std_logic;

component Full_adder is 
	port (a, b, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end component; 

begin 
x3 <= SW(7); 
y3 <= SW(6); 
x2 <= SW(5); 
y2 <= SW(4);
x1 <= SW(3);
y1 <= SW(2);
x0 <= SW(1);
y0 <= SW(0);

hex0 <=
hex1 <=
hex2 <=
hex3 <=

component_1: entity work.Full_adder(RTL) port map(x0, y0, '0', s0, cout1); 
component_2: entity work.Full_adder(RTL) port map(x1, y1, cout1, s1, cout2);
component_3: entity work.Full_adder(RTL) port map(x2, y2, cout2, s2, cout3); 
component_4: entity work.Full_adder(RTL) port map(x3, y3, cout3, s3, cout4); 
 

LEDG(0) <= s0;
LEDG(1) <= s1;
LEDG(2) <= s2;
LEDG(3) <= s3;
LEDG(4) <= cout4;

end architecture; 