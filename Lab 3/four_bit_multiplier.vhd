library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_multiplier is 
port( SW: in std_logic_vector(9 downto 0);
		HEX0: out std_logic_vector(6 downto 0);
		HEX1: out std_logic_vector(6 downto 0);
		HEX2: out std_logic_vector(6 downto 0);
		HEX3: out std_logic_vector(6 downto 0));
end entity; 


architecture RTL of four_bit_multiplier is 
signal x0,x1,x2,x3: 							std_logic; -- 4 bit input
signal y0,y1,y2,y3: 							std_logic; -- 4 bit input
signal g1_0, g1_1, g1_2, g1_3, g1_4: 	std_logic; 
signal g2_0, g2_1, g2_2, g2_3, g2_4: 	std_logic; 
signal g3_0, g3_1, g3_2, g3_3, g3_4: 	std_logic; 
signal p0, p1, p2, p3, p4, p5, p6, p7: std_logic; -- 7 bit output
signal blanking: std_logic;

component four_bit_adder is 
	port (a0, a1, a2, a3, b0, b1, b2, b3:	in  std_logic; 
			p0, p1, p2, p3, p4: 					out std_logic); 
end component; 

component seven_segment is 
port(
		input:		in std_logic_vector(3 downto 0);	-- 4 bit inputs
		blanking:		in std_logic;
		output: 	out std_logic_vector(6 downto 0) );	-- 7 bit output display
end component; 

begin 

x0 <= SW(0);
x1 <= SW(1);
x2 <= SW(2);
x3 <= SW(3);
y0 <= SW(4);
y1 <= SW(5);
y2 <= SW(6);
y3 <= SW(7);

component_1: entity work.four_bit_adder(RTL) port map((x0 and y1), (x1 and y1), (x2 and y1), (x3 and y1),(x1 and y0),
																		(x2 and y0) , (x3 and y0) ,'0', g1_0, g1_1, g1_2, g1_3, g1_4); 
component_2: entity work.four_bit_adder(RTL) port map((x0 and y2), (x1 and y2), (x2 and y2), (x3 and y2), g1_1, g1_2,
																		 g1_3, g1_4, g2_0, g2_1, g2_2, g2_3, g2_4); 
component_3: entity work.four_bit_adder(RTL) port map((x0 and y3), (x1 and y3), (x2 and y3), (x3 and y3), g2_1, g2_2,
																		 g2_3, g2_4, g3_0, g3_1, g3_2, g3_3, g3_4); 

p0 <= x0 and y0;

p1 <= g1_0;
p2 <= g2_0;
p3 <= g3_0;
p4 <= g3_1;
p5 <= g3_2;
p6 <= g3_3;
p7 <= g3_4;

blanking <= '0' when ((p7 = '1') or (p6 = '1') or (p5 = '1') or (p4 = '1')) else '1';

component_5: entity work.seven_segment(behavioral) port map((y3 & y2 & y1 & y0), '0', HEX3); 
component_6: entity work.seven_segment(behavioral) port map((x3 & x2 & x1 & x0), '0', HEX2); 
component_7: entity work.seven_segment(behavioral) port map((p7 & p6 & p5 & p4), blanking, HEX1); 
component_8: entity work.seven_segment(behavioral) port map((p3 & p2 & p1 & p0), '0', HEX0); 


end architecture; 
