library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_adder is 
	port (a0, a1, a2, a3:   in std_logic;
			b0, b1, b2, b3:	in  std_logic; 
			p0, p1, p2, p3, p4: 	out std_logic); 
end entity; 


architecture RTL of four_bit_adder  is 
signal c1, c2, c3: std_logic; 
signal s0, s1, s2, s3, c4: std_logic;


component Full_adder is 
	port (x, y, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end component; 

begin 

component_1: entity work.Full_adder(RTL) port map(a0, b0, '0', s0, c1); 
component_2: entity work.Full_adder(RTL) port map(a1 , b1 , c1, s1, c2); 
component_3: entity work.Full_adder(RTL) port map(a2 , b2 , c2, s2, c3); 
component_4: entity work.Full_adder(RTL) port map(a3 , b3 , c3, s3, c4); 


p0 <= s0;
p1 <= s1;
p2 <= s2;
p3 <= s3;
p4 <= c4;

end architecture; 

