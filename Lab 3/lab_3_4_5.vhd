-- Implements ALU system which computes four-bit addition and muliplication
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab_3_4_5 is 
	port (
		SW: 	in	std_logic_vector(9 downto 0);
		HEX0:	out	std_logic_vector(6 downto 0);
		HEX1:	out	std_logic_vector(6 downto 0);
		HEX2:	out	std_logic_vector(6 downto 0);
		HEX3:	out	std_logic_vector(6 downto 0)
	); 
	end entity; 

architecture RTL of lab_3_4_5 is 
signal x0, x1, x2, x3, y0, y1, y2, y3:	std_logic; -- two 4 bit inputs x, y
signal s4, s3, s2, s1, s0:		std_logic; -- four bit adder outputs
signal p7, p6, p5, p4, p3, p2, p1, p0:	std_logic; -- four bit multiplier output
signal r7, r6, r5, r4, r3, r2, r1, r0:	std_logic; -- final alu outputs
signal sw_status : std_logic; 

component  four_bit_adder is 
	port (
		a0, a1, a2, a3, b0, b1, b2, b3:	in  std_logic; 
		p0, p1, p2, p3, p4: 		out std_logic
	);
end component; 

component four_bit_multiplier is 
	port (
		x0,x1,x2,x3:   			in	std_logic; -- 4 bit input
		y0,y1,y2,y3: 			in	std_logic;
		p0, p1, p2, p3, p4, p5, p6, p7: out	std_logic); 
end component; 

begin 
x3 <= SW(9);
x2 <= SW(8);
x1 <= SW(7);
x0 <= SW(6);
sw_status <= SW(5);
y3 <= SW(3);
y2 <= SW(2);
y1 <= SW(1);
y0 <= SW(0);

component_1: entity work.four_bit_adder(RTL) port map(x0, x1, x2, x3, y0, y1, y2, y3, s0, s1, s2, s3, s4); 
component_2: entity work.four_bit_multiplier(RTL) port map(x0, x1, x2, x3, y0, y1, y2, y3, p0, p1, p2, p3, p4, p5, p6, p7); 

r0 <= p0 when (sw_status = '0') else s0;
r1 <= p1 when (sw_status = '0') else s1;
r2 <= p2 when (sw_status = '0') else s2;
r3 <= p3 when (sw_status = '0') else s3;
r4 <= p4 when (sw_status = '0') else s4;
r5 <= p5 when (sw_status = '0') else '0';
r6 <= p6 when (sw_status = '0') else '0';
r7 <= p7 when (sw_status = '0') else '0';

blanking <= '0' when ((r7 = '1') or (r6 = '1') or (r5 = '1') or (r4 = '1')) else '1';

hex0_inst: entity work.seven_segment(behavioral) port map((x3 & x2 & x1 & x0), '0', HEX3);
hex1_inst: entity work.seven_segment(behavioral) port map((y3 & y2 & y1 & y0), '0', HEX2);
hex2_inst: entity work.seven_segment(behavioral) port map((r7 & r6 & r5 & r4), blanking, HEX1);
hex3_inst: entity work.seven_segment(behavioral) port map((r3 & r2 & r1 & r0), '0', HEX0);

end architecture; 
