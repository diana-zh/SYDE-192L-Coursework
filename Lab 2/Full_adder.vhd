library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Full_adder is 
	port (x, y, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end entity; 

architecture RTL of Full_adder is 
signal s_1, cout_1: std_logic; 
signal s_2, cout_2: std_logic; 

component Half_adder is 
	port (a, b: 	in  std_logic; 
			S, C: 	out std_logic); 
end component; 

begin 
component_1: entity work.Half_adder(RTL) port map(x, y, s_1, cout_1); 
component_2: entity work.Half_adder(RTL) port map(s_1, cin, s_2, cout_2); 
s <= s_2; 
cout <= cout_1 or cout_2; 
end architecture; 