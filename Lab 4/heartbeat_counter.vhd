library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity heartbeat_counter is 
	port(
			KEY:  in std_logic_vector(1 downto 0);
			LEDG: out std_logic_vector(4 downto 0);
			HEX0: out std_logic_vector(6 downto 0);
			HEX1: out std_logic_vector(6 downto 0)
			);
	end entity; 

architecture main of heartbeat_counter is
	signal counter:      unsigned(4 downto 0);
	signal blanking: std_logic;
	
	
component seven_segment is 
	port(
			input:		in std_logic_vector(3 downto 0);	
			blanking:		in std_logic;
			output: 	out std_logic_vector(6 downto 0));	
	end component; 

begin

	counter <= counter + 1 when rising_edge(KEY(0));
	
	blanking <= '0' when (counter(4) = '1') else '1';
	
	LEDG(0) <= counter(0);
	LEDG(1) <= counter(1);
	LEDG(2) <= counter(2);
	LEDG(3) <= counter(3);
	LEDG(4) <= counter(4);
	
	hex0_inst: entity work.seven_segment(behavioral) port map((counter(3) & counter(2) & counter(1) & counter(0)), '0', HEX0);
	hex1_inst: entity work.seven_segment(behavioral) port map("000" & (counter(4)), blanking, HEX1);


end architecture; 