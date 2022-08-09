library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Half_adder is 
	port (x, y: 			in std_logic; 
			Sum, Carry: 	out std_logic); 
end entity; 

architecture RTL of Half_adder is 
begin 
Sum <= x xor y; 
Carry <= x and y; 
end architecture; 