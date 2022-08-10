-- An extension of Lab_3_4_2, this takes the four-bit adder system and outputs results onto HEX outputs
library ieee;					
use ieee.std_logic_1164.all;	

entity lab_3_4_3 is 	-- entity definition 
	port (
		SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
		LEDG:		out 	std_logic_vector(9 downto 0);
		HEX0:		out	std_logic_vector(6 downto 0);
		HEX1:		out	std_logic_vector(6 downto 0);
		HEX2:		out	std_logic_vector(6 downto 0);
		HEX3:		out	std_logic_vector(6 downto 0)
			);   -- Red switches
end entity; 

architecture RTL of lab_3_4_3 is 
signal x0, y0, x1, y1, x2, y2, x3, y3:	std_logic;	-- Naming inputs
signal cout1, cout2, cout3, cout4: std_logic; 
signal s0, s1, s2, s3: std_logic;
signal blanking: std_logic;


component Full_adder is 
	port (
		a, b, cin: 	in  std_logic; 
		s, cout: 	out std_logic); 
end component;

component seven_segment is 
	port (
		segments_in, blanking: 	in std_logic;
		segments_out: 		out std_logic);
end component;

begin  
x3 <= SW(7); 
x2 <= SW(6); 
x1 <= SW(5); 
x0 <= SW(4);
y3 <= SW(3);
y2 <= SW(2);
y1 <= SW(1);
y0 <= SW(0);

component_1: entity work.Full_adder(RTL) port map(x0, y0, '0', s0, cout1); 
component_2: entity work.Full_adder(RTL) port map(x1, y1, cout1, s1, cout2);
component_3: entity work.Full_adder(RTL) port map(x2, y2, cout2, s2, cout3); 
component_4: entity work.Full_adder(RTL) port map(x3, y3, cout3, s3, cout4);

blanking <= '0' when (cout4 = '1') else '1';

hex0_inst: entity work.seven_segment(behavioral) port map((x3 & x2 & x1 & x0), '0', HEX3);
hex1_inst: entity work.seven_segment(behavioral) port map((y3 & y2 & y1 & y0), '0', HEX2);
hex2_inst: entity work.seven_segment(behavioral) port map(("000" & cout4), blanking, HEX1);
hex3_inst: entity work.seven_segment(behavioral) port map((s3 & s2 & s1 & s0), '0', HEX0);


LEDG(0) <= s0;
LEDG(1) <= s1;
LEDG(2) <= s2;
LEDG(3) <= s3;
LEDG(4) <= cout4;

end architecture; 
