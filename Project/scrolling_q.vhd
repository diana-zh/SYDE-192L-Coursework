
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity scrolling_q is 
	port(CLOCK_50_B5B:	in  std_logic ; 
		 GPIO:			out std_logic_vector(35 downto 0)); 
end entity scrolling_q; 

Architecture main of scrolling_q is 
signal counter_100Hz: unsigned(24 downto 0) := to_unsigned(249999, 25);
signal scroll_counter: unsigned(24 downto 0) := to_unsigned(249999, 25); 
signal column_counter: unsigned(3 downto 0) := to_unsigned(1, 4);

signal clock: std_logic;
signal row_driver: std_logic_vector(0 to 7) := "10000000";
signal col_driver: std_logic_vector(0 to 7) := "11111111";


signal col_1: std_logic_vector(0 to 7) := "10001111"; -- initial displays of the columns to show 'G'
signal col_2: std_logic_vector(0 to 7) := "01110111";
signal col_3: std_logic_vector(0 to 7) := "01111111"; 
signal col_4: std_logic_vector(0 to 7) := "01111111";
signal col_5: std_logic_vector(0 to 7) := "01000111"; 
signal col_6: std_logic_vector(0 to 7) := "01110111";
signal col_7: std_logic_vector(0 to 7) := "10000111"; 
signal col_8: std_logic_vector(0 to 7) := "11111111"; 

begin 

scrolling: process (CLOCK_50_B5B)
begin
	if rising_edge(CLOCK_50_B5B) then
		if counter_100Hz = to_unsigned(24999, 25) then
			counter_100Hz <= to_unsigned(0, 25);
			clock <= not clock;
		else
			counter_100Hz <= counter_100Hz + 1;
		end if;
	end if;
			
		
end process scrolling;

scrolling_counter: process (CLOCK_50_B5B)
begin
	if rising_edge(CLOCK_50_B5B) then
		if scroll_counter = to_unsigned(24999999, 25) then
			scroll_counter <= to_unsigned(0, 25);
			col_1 <= col_1(1 to 7) & col_1(0);
			col_2 <= col_2(1 to 7) & col_2(0);
			col_3 <= col_3(1 to 7) & col_3(0);
			col_4 <= col_4(1 to 7) & col_4(0);
			col_5 <= col_5(1 to 7) & col_5(0);
			col_6 <= col_6(1 to 7) & col_6(0);
			col_7 <= col_7(1 to 7) & col_7(0);
			col_8 <= col_8(1 to 7) & col_8(0);
		else
			scroll_counter <= scroll_counter + 1;
		end if;
	end if;
			
		
end process scrolling_counter;


col_driver <=  col_1 when row_driver = "10000000" else -- designating cols to rows
					col_2 when row_driver = "01000000" else
					col_3 when row_driver = "00100000" else
					col_4 when row_driver = "00010000" else
					col_5 when row_driver = "00001000" else
					col_6 when row_driver = "00000100" else
					col_7 when row_driver = "00000010" else
					col_8;
					
row_driver <= row_driver(7) & row_driver(0 to 6) when rising_edge(clock);



GPIO( 0) <= row_driver(0);	GPIO( 1) <= row_driver(0); 	-- Pin connections between GPIO port and the PCB 
GPIO( 2) <= row_driver(1);	GPIO( 3) <= row_driver(1); 
GPIO( 4) <= row_driver(2);	GPIO( 5) <= row_driver(2); 
GPIO( 6) <= row_driver(3);	GPIO( 7) <= row_driver(3); 
GPIO( 8) <= row_driver(4);	GPIO( 9) <= row_driver(4); 
GPIO(10) <= row_driver(5);	GPIO(11) <= row_driver(5); 
GPIO(12) <= row_driver(6);	GPIO(13) <= row_driver(6); 
GPIO(14) <= row_driver(7);	GPIO(15) <= row_driver(7); 

GPIO(20) <= col_driver(0);	GPIO(21) <= col_driver(0); 
GPIO(22) <= col_driver(1);	GPIO(23) <= col_driver(1); 
GPIO(24) <= col_driver(2);	GPIO(25) <= col_driver(2); 
GPIO(26) <= col_driver(3);	GPIO(27) <= col_driver(3); 
GPIO(28) <= col_driver(4);	GPIO(29) <= col_driver(4); 
GPIO(30) <= col_driver(5);	GPIO(31) <= col_driver(5); 
GPIO(32) <= col_driver(6);	GPIO(33) <= col_driver(6); 
GPIO(34) <= col_driver(7);	GPIO(35) <= col_driver(7); 
end architecture main;