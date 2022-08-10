library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Random_num_gen is 
	port(
			KEY: in std_logic_vector(1 downto 0);
			HEX0, HEX1: out std_logic_vector(6 downto 0);
			HEX2, HEX3: out std_logic_vector(6 downto 0);
			CLOCK_50_B5B: in std_logic);
	end entity; 

architecture main of Random_num_gen is

signal rndm: unsigned(7 downto 0);
signal h_0, h_1, h_2, h_3, h_4: std_logic_vector(3 downto 0);
signal blank: std_logic:='1'; -- blanking by default
signal first_blank: std_logic:='1';

component seven_segment is port(

	data_in: in std_logic_vector(3 downto 0); 
	blanking: in std_logic; 
	segments_out: out std_logic_vector(6 downto 0) ); 

end component;

begin

rndm <= rndm + 1 when rising_edge(CLOCK_50_B5B);

blank <= '0' when rising_edge(KEY(0));
first_blank <= blank when rising_edge(KEY(0)); -- is delayed by one key press


h_0 <= std_logic_vector(rndm(3 downto 0)) when rising_edge(KEY(0));
h_1 <= std_logic_vector(rndm(7 downto 4)) when rising_edge(KEY(0));
h_2 <= h_0 when rising_edge(KEY(0));
h_3 <= h_1 when rising_edge(KEY(0));

hex_component_1: entity work.seven_segment(behavioral) port map(h_0, blank, HEX0);
hex_component_2: entity work.seven_segment(behavioral) port map(h_1, blank, HEX1);
hex_component_3: entity work.seven_segment(behavioral) port map(h_2, first_blank, HEX2);
hex_component_4: entity work.seven_segment(behavioral) port map(h_3, first_blank, HEX3);

 

end architecture; 