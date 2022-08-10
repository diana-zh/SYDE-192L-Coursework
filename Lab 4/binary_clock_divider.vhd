library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_clock_divider is 
	port(
		LEDG: out std_logic_vector(7 downto 0);
		LEDR: out std_logic_vector(9 downto 0);
		CLOCK_50_B5B: in std_logic
		);
	end entity; 

architecture main of binary_clock_divider is
	signal counter:   unsigned(31 downto 0);

begin

counter <= counter + 1 when rising_edge(CLOCK_50_B5B);

-- LEDR 31 downto 22
LEDR(9) <= counter(31);
LEDR(8) <= counter(30);
LEDR(7) <= counter(29);
LEDR(6) <= counter(28);
LEDR(5) <= counter(27);
LEDR(4) <= counter(26);
LEDR(3) <= counter(25);
LEDR(2) <= counter(24);
LEDR(1) <= counter(23);
LEDR(0) <= counter(22);

-- LEDG 21 downto 14
LEDG(7) <= counter(21);
LEDG(6) <= counter(20);
LEDG(5) <= counter(19);
LEDG(4) <= counter(18);
LEDG(3) <= counter(17);
LEDG(2) <= counter(16);
LEDG(1) <= counter(15);
LEDG(0) <= counter(14);


end architecture; 
