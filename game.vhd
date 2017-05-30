LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;

ENTITY game IS
   PORT(	clk, rom_mux, bt0, bt1, bt2, sw0	: IN STD_LOGIC;
			RGB									: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			game_mode							: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			red_data, green_data, blue_data		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END game;

architecture behavior of game is

SIGNAL Red_Data_t  		 : std_logic_vector(3 downto 0) := "1111";
SIGNAL Green_Data_t		 : std_logic_vector(3 downto 0) := "1111";
SIGNAL Blue_Data_t 		 : std_logic_vector(3 downto 0) := "1111";
SIGNAL s_game_mode		 : std_logic_vector(2 downto 0) := "000";


BEGIN
PROCESS(rom_mux, clk)
BEGIN
	IF rising_edge(clk) THEN
		IF bt2 = '0' THEN -- Skip Level
			IF s_game_mode = "010" THEN
				s_game_mode <= "011";
			ELSIF s_game_mode = "100" THEN
				s_game_mode <= "101";
			ELSIF s_game_mode = "110" THEN
				s_game_mode <= "111";
			ELSIF s_game_mode = "001" THEN
				s_game_mode <= "000";
			END IF;
		END IF;
		
		IF bt1 = '0' THEN -- Reset
			s_game_mode <= "000";
		END IF;

		IF bt0 = '0' THEN -- Enter
			IF s_game_mode = "000" THEN
				IF sw0 = '0' THEN
					s_game_mode <= "001"; -- Practice Mode
				ELSE
					s_game_mode <= "010"; -- Level ௧
				END IF;
			ELSIF s_game_mode = "011" THEN
				s_game_mode <= "100"; -- Level ௨
			ELSIF s_game_mode = "101" THEN
				s_game_mode <= "110"; -- Level ௩
			END IF;
		END IF;
	END IF;

	Red_Data_t <= RGB(3 DOWNTO 0);
	Green_Data_t <= RGB(7 DOWNTO 4);
	Blue_Data_t <= RGB(11 DOWNTO 8);
	
	IF s_game_mode = "000" THEN
		Red_Data_t <= "0000";
		Green_Data_t <= "0000";
		Blue_Data_t <= "0000";
	END IF;
	
	IF rom_mux = '1' THEN
		Red_Data_t <= "0000";
		Green_Data_t <= "0000";
		Blue_Data_t <= "1111";
	END IF;
	
	
END PROCESS;

Red_Data <= Red_Data_t;
Green_Data <= Green_Data_t;
Blue_Data <= Blue_Data_t;
game_mode <= s_game_mode;

END behavior;