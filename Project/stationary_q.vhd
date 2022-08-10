library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stationary_q is 
	port(CLOCK_50_B5B:	in  std_logic ;    -- 50MHz clock on the board 
		 GPIO:			out std_logic_vector(35 downto 0)); 
end entity stationary_q; 

Architecture main of stationary_q is 
signal counter_100hz: unsigned(19 downto 0); 
signal clock_100hz: std_logic;
signal row_driver: std_logic_vector(0 to 7) := "10000000";
signal col_driver: std_logic_vector(0 to 8) := "101111111";
--col driver: must shift 0 rightwards. use arithmetic shifting to ensure there's only one 0 in the col driver
-- using 9 bits for col driver so we can make sure MSB is 1 so we can employ arithmetic shifting
-- (replaces MSB with MSB rather than a 0)


begin
	counter: process (CLOCK_50_B5B) -- 100Hz counter
	begin
		if rising_edge(CLOCK_50_B5B) then
			if counter_100hz = to_unsigned(24999, 20) then
				counter_100hz <= to_unsigned(0, 20);
				clock_100hz <= not clock_100hz;
			else
				counter_100hz <= counter_100hz + 1;
			end if;
		end if;    
	end process;
	
	
	increment_col_driver: process(clock_100hz)
	begin
	
		if rising_edge(clock_100hz) then
		-- shifting col_driver only
			if col_driver = "111111110" then --at the end of row
				col_driver <= "101111111"; -- col driver reset to light up first LED

			else
				col_driver <= std_logic_vector(shift_right(signed(col_driver), 1)); --right arithmetic shift, replace with MSB
			end if;
			

			-- stationary g
			-- checking which rows we display the designated col
			if col_driver 		<= "101111111" then row_driver 	<= "01111100";
			elsif col_driver 	<= "110111111" then row_driver 	<= "10000010";
			elsif col_driver 	<= "1110111111" then row_driver 	<= "10001010";
			elsif col_driver 	<= "1111011111" then row_driver 	<= "10001010";
			elsif col_driver 	<= "1111101111" then row_driver 	<= "01001110";
			else row_driver 	<= "00000000";

			end if;
			
		end if;
	end process;
	

GPIO( 0) <= row_driver(0);	GPIO( 1) <= row_driver(0); 	-- Pin connections between GPIO port and the PCB 
GPIO( 2) <= row_driver(1);	GPIO( 3) <= row_driver(1); 
GPIO( 4) <= row_driver(2);	GPIO( 5) <= row_driver(2); 
GPIO( 6) <= row_driver(3);	GPIO( 7) <= row_driver(3); 
GPIO( 8) <= row_driver(4);	GPIO( 9) <= row_driver(4); 
GPIO(10) <= row_driver(5);	GPIO(11) <= row_driver(5); 
GPIO(12) <= row_driver(6);	GPIO(13) <= row_driver(6); 
GPIO(14) <= row_driver(7);	GPIO(15) <= row_driver(7); 

GPIO(20) <= col_driver(1);	GPIO(21) <= col_driver(1); 
GPIO(22) <= col_driver(2);	GPIO(23) <= col_driver(2); 
GPIO(24) <= col_driver(3);	GPIO(25) <= col_driver(3); 
GPIO(26) <= col_driver(4);	GPIO(27) <= col_driver(4); 
GPIO(28) <= col_driver(5);	GPIO(29) <= col_driver(5); 
GPIO(30) <= col_driver(6);	GPIO(31) <= col_driver(6); 
GPIO(32) <= col_driver(7);	GPIO(33) <= col_driver(7); 
GPIO(34) <= col_driver(8);	GPIO(35) <= col_driver(8); 
end architecture main; 



