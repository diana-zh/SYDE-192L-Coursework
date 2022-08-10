library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light is 
	port(	LEDR: out std_logic_vector(7 downto 0);
			LEDG: out std_logic_vector(7 downto 0);
			HEX0: 	out std_logic_vector(6 downto 0);
			HEX3: 	out std_logic_vector(6 downto 0);
			CLOCK_50_B5B: 	in std_logic);
			
end entity;

architecture RTL of traffic_light is

type traffic_states is (NS_green_f, NS_green_s, NS_yellow, NS_red,
								EW_green_f, EW_green_s, EW_yellow, EW_red);
								
						
signal state, next_state:		traffic_states;
signal state_num: 		unsigned(2 downto 0);	
signal counter_Hz:		unsigned(21 downto 0);
signal state_counter: 	unsigned(3 downto 0);
signal helper_counter: 				unsigned(4 downto 0);			
signal clock_10_Hz: 		std_logic;
signal final_clock: 		unsigned(3 downto 0);


component seven_segment is 
	port (data_in: 	  in  std_logic_vector(3 downto 0); 
			blanking: 	  in  std_logic;
			segments_out: out std_logic_vector(6 downto 0));
end component; 

begin

t_lights: process (CLOCK_50_B5B)

begin

	if rising_edge(CLOCK_50_B5B) then
		if counter_Hz = to_unsigned(2499999, 22) then
			counter_Hz <= to_unsigned(0, 22);
			clock_10_Hz <= not clock_10_Hz;

			helper_counter <= helper_counter + 1;
			
		if helper_counter = to_unsigned(20, 5) then
			helper_counter <= to_unsigned(0, 5);
			state_counter <= state_counter + 1;
		end if;
		
	else
		counter_Hz <= counter_Hz + 1;
	end if;
	
	case state is
		
		-- North West traffic lights
		when NS_green_f =>
			LEDG(7) <= clock_10_Hz;
			LEDR(0) <= '0';
			LEDR(4) <= '1';
			state_num <= to_unsigned(0, 3);
			
			if state_counter = 2 then
				state_counter <= to_unsigned(0,4);
				state <= NS_green_s;
			end if;
			
		when NS_green_s =>
			LEDG(7) <= '1';
			LEDR(4) <= '1';
			state_num <= to_unsigned(1, 3);
			
			if state_counter = 5 then
				state_counter <= to_unsigned(0,4);
				state <= NS_yellow;
			end if;
			
		when NS_yellow =>
			LEDG(7) <= '0';
			LEDR(0) <= clock_10_Hz;
			-- LEDR(4) <= '1';
			state_num <= to_unsigned(2, 3);
			
			if state_counter = 3 then
				state_counter <= to_unsigned(0,4);
				state <= NS_red;
			end if;
		
		when NS_red =>
			LEDR(0) <= '1';
			LEDR(4) <= '1';
			state_num <= to_unsigned(3, 3);
			
			if state_counter = 1 then
				state_counter <= to_unsigned(0,4);
				state <= EW_green_f;
			end if;
		
		
		-- East West traffic lights
		when EW_green_f =>
			LEDR(0) <= '1';
			LEDR(4) <= '0';
			LEDG(4) <= clock_10_Hz;
			state_num <= to_unsigned(4, 3);
			
			if state_counter = 2 then
				state_counter <= to_unsigned(0,4);
				state <= EW_green_s;
			end if;
			
		when EW_green_s =>
			LEDR(0) <= '1';
			LEDG(4) <= '1';
			state_num <= to_unsigned(5, 3);
			
			if state_counter = 5 then
				state_counter <= to_unsigned(0,4);
				state <= EW_yellow;
			end if;
			
		when EW_yellow =>
			LEDR(0) <= '1';
			LEDG(4) <= '0';
			LEDR(4) <= clock_10_Hz;
			state_num <= to_unsigned(6, 3);
			
			if state_counter = 3 then
				state_counter <= to_unsigned(0,4);
				state <= EW_red;
			end if;
		
		when EW_red =>
			LEDR(0) <= '1';
			LEDR(4) <= '1';
			state_num <= to_unsigned(7, 3);
			
			if state_counter = 1 then
				state_counter <= to_unsigned(0,4);
				state <= NS_green_f;
			end if;
		end case;
	end if;
end process;

hex_inst_1: entity work.seven_segment(behavioral) port map('0' & std_logic_vector(state_num), '0', HEX3);
hex_inst_4: entity work.seven_segment(behavioral) port map(std_logic_vector(state_counter), '0', HEX0);


end architecture;
		
			
	
	
	
	
	
	
	
	

