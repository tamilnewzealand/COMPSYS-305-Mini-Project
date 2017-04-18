LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;

ENTITY game IS
   PORT(	clk, rom_mux, bt0, bt1, sw0			: IN STD_LOGIC;
			game_mode							: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			red_data, green_data, blue_data		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END game;

architecture behavior of game is

SIGNAL Red_Data_t  		 : std_logic_vector(3 downto 0) := "0000";
SIGNAL Green_Data_t		 : std_logic_vector(3 downto 0) := "0000";
SIGNAL Blue_Data_t 		 : std_logic_vector(3 downto 0) := "0000";
SIGNAL s_game_mode		 : std_logic_vector(1 downto 0) := "00";

BEGIN
PROCESS(rom_mux, clk)
BEGIN
	IF rising_edge(clk) THEN
		IF bt1 = '0' THEN
			s_game_mode <= "00";
		END IF;

		IF bt0 = '0' THEN
			IF sw0 = '0' THEN
				s_game_mode <= "10";
			ELSE
				s_game_mode <= "11";
			END IF;
		END IF;
	END IF;
	
	IF rom_mux = '1' THEN -- rendering text
		Red_Data_t <= "1111";
		Green_Data_t <= "1111";
		Blue_Data_t <= "1111";
	ELSE
		Red_Data_t <= "0000";
		Green_Data_t <= "0000";
		Blue_Data_t <= "0000";
	END IF;
END PROCESS;

Red_Data <= Red_Data_t;
Green_Data <= Green_Data_t;
Blue_Data <= Blue_Data_t;
game_mode <= s_game_mode;

END behavior;