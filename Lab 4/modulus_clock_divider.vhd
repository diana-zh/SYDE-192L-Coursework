library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulus_clock_divider is 
	port(
		LEDG: out std_logic_vector(1 downto 0);
		LEDR: out std_logic_vector(1 downto 0);
		CLOCK_50_B5B: in std_ulogic);
	end entity; 

architecture main of  modulus_clock_divider is
	signal counter1:	unsigned(24 downto 0);
	signal counter2:	unsigned(25 downto 0);
	signal clock_1_Hz: 	std_logic;


begin

counting: process (CLOCK_50_B5B)

	begin
		if rising_edge(CLOCK_50_B5B) then
			if counter1 = to_unsigned(24999999, 25) then
				counter1 <= to_unsigned(0, 25);
				clock_1_Hz <= not clock_1_Hz;
				LEDG(0) <= clock_1_hz; 
			else
				counter1 <= counter1 + 1;
			end if;
		end if;
	end process;

counter2 <= counter2 + 1 when rising_edge(CLOCK_50_B5B);
LEDR(0) <= counter2(25);


end architecture; 
