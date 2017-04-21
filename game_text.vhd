LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY game_text IS
   PORT(signal sw0							: in std_logic;
		  signal pixel_column, pixel_row	: in std_logic_vector(10 downto 0);
		  signal game_mode					: in std_logic_vector(2 downto 0);
		  signal score						: in std_logic_vector(7 downto 0);
		  signal time_low, time_high		: in std_logic_vector(0 to 3);
		  signal char_add					: out std_logic_vector(5 downto 0);
		  signal char_row, char_col			: out std_logic_vector(2 downto 0));
end game_text;

architecture behavior of game_text is

signal pixel_row_t, pixel_column_t			: std_logic_vector(10 downto 0);
signal tens, ones 							: std_logic_vector(5 downto 0);
signal time_tens, time_ones 				: std_logic_vector(5 downto 0);
signal score_tens, score_ones 				: std_logic_vector(3 downto 0);
signal level_num							: std_logic_vector(5 downto 0);

begin           

score_ones <= score(3 downto 0);
score_tens <= score(7 downto 4);
pixel_column_t <= pixel_column;
pixel_row_t <= pixel_row;

Digit_process : process (score_ones, score_tens, game_mode)
begin
	case score_ones is
		when "0000" => ones <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
		when "0001" => ones <= CONV_STD_LOGIC_VECTOR(49, 6); -- 1
		when "0010" => ones <= CONV_STD_LOGIC_VECTOR(50, 6); -- 2
		when "0011" => ones <= CONV_STD_LOGIC_VECTOR(51, 6); -- 3
		when "0100" => ones <= CONV_STD_LOGIC_VECTOR(52, 6); -- 4
		when "0101" => ones <= CONV_STD_LOGIC_VECTOR(53, 6); -- 5
		when "0110" => ones <= CONV_STD_LOGIC_VECTOR(54, 6); -- 6
		when "0111" => ones <= CONV_STD_LOGIC_VECTOR(55, 6); -- 7
		when "1000" => ones <= CONV_STD_LOGIC_VECTOR(56, 6); -- 8
		when "1001" => ones <= CONV_STD_LOGIC_VECTOR(57, 6); -- 9
		when OTHERS => ones <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
	end case;
	case score_tens is
		when "0000" => tens <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
		when "0001" => tens <= CONV_STD_LOGIC_VECTOR(49, 6); -- 1
		when "0010" => tens <= CONV_STD_LOGIC_VECTOR(50, 6); -- 2
		when "0011" => tens <= CONV_STD_LOGIC_VECTOR(51, 6); -- 3
		when "0100" => tens <= CONV_STD_LOGIC_VECTOR(52, 6); -- 4
		when "0101" => tens <= CONV_STD_LOGIC_VECTOR(53, 6); -- 5
		when "0110" => tens <= CONV_STD_LOGIC_VECTOR(54, 6); -- 6
		when "0111" => tens <= CONV_STD_LOGIC_VECTOR(55, 6); -- 7
		when "1000" => tens <= CONV_STD_LOGIC_VECTOR(56, 6); -- 8
		when "1001" => tens <= CONV_STD_LOGIC_VECTOR(57, 6); -- 9
		when OTHERS => tens <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
	end case;
		case time_low is
		when "0000" => time_ones <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
		when "0001" => time_ones <= CONV_STD_LOGIC_VECTOR(49, 6); -- 1
		when "0010" => time_ones <= CONV_STD_LOGIC_VECTOR(50, 6); -- 2
		when "0011" => time_ones <= CONV_STD_LOGIC_VECTOR(51, 6); -- 3
		when "0100" => time_ones <= CONV_STD_LOGIC_VECTOR(52, 6); -- 4
		when "0101" => time_ones <= CONV_STD_LOGIC_VECTOR(53, 6); -- 5
		when "0110" => time_ones <= CONV_STD_LOGIC_VECTOR(54, 6); -- 6
		when "0111" => time_ones <= CONV_STD_LOGIC_VECTOR(55, 6); -- 7
		when "1000" => time_ones <= CONV_STD_LOGIC_VECTOR(56, 6); -- 8
		when "1001" => time_ones <= CONV_STD_LOGIC_VECTOR(57, 6); -- 9
		when OTHERS => time_ones <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
	end case;
	case time_high is
		when "0000" => time_tens <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
		when "0001" => time_tens <= CONV_STD_LOGIC_VECTOR(49, 6); -- 1
		when "0010" => time_tens <= CONV_STD_LOGIC_VECTOR(50, 6); -- 2
		when "0011" => time_tens <= CONV_STD_LOGIC_VECTOR(51, 6); -- 3
		when "0100" => time_tens <= CONV_STD_LOGIC_VECTOR(52, 6); -- 4
		when "0101" => time_tens <= CONV_STD_LOGIC_VECTOR(53, 6); -- 5
		when "0110" => time_tens <= CONV_STD_LOGIC_VECTOR(54, 6); -- 6
		when "0111" => time_tens <= CONV_STD_LOGIC_VECTOR(55, 6); -- 7
		when "1000" => time_tens <= CONV_STD_LOGIC_VECTOR(56, 6); -- 8
		when "1001" => time_tens <= CONV_STD_LOGIC_VECTOR(57, 6); -- 9
		when OTHERS => time_tens <= CONV_STD_LOGIC_VECTOR(48, 6); -- 0
	end case;
	case game_mode is
		when "010" => level_num <= CONV_STD_LOGIC_VECTOR(49, 6); -- level 1
		when "100" => level_num <= CONV_STD_LOGIC_VECTOR(50, 6); -- level 2
		when "110" => level_num <= CONV_STD_LOGIC_VECTOR(51, 6); -- level 3
		when others => level_num <= CONV_STD_LOGIC_VECTOR(32, 6); -- blank
	end case;
end process;

TEXT_Display: process (pixel_column_t, pixel_row_t, sw0)
begin
	-- माईन मेनू स्क्रीन
	if game_mode = "000" then
		--Display *TANK GAME*
		--*
		if (pixel_column_t >= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(157, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(42, 6);
		--T
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(160, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(20, 6);
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);
		--N
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(14, 6);
		--K
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(11, 6);
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		--G
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(7, 6);
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);
		--M
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(416, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(13, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(416, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(448, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		--*
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(448, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(477, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(42, 6);

		--GAME	
		--G
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(335, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(7, 6);
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(335, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);
		--M
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(335, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(13, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(335, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);

		--PRACTICE
		--P
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(16, 6);
		--R
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(18, 6);
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--T
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(20, 6);
		--I
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(9, 6);
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(368, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(368, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		
		--GAME SEL 1
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(240, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(335, 10)) and
			(sw0 = '1') then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(41, 6);
		--GAME SEL 2
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(400, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(335, 10)) and
			(sw0 = '1') then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(40, 6);
		--PRACTICE SEL 1
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(240, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) and
			(sw0 = '0') then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(41, 6);
		--PRACTICE SEL 2
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(400, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) and
			(sw0 = '0') then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(40, 6);

		-- Display: GROUPXX: Adil & Sakayan
		--G
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(16, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(32, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(7, 6);
		--R
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(32, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(48, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(18, 6);
		--O
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(48, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(64, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(15, 6);
		--U
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(64, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(80, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(21, 6);
		--P
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(80, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(16, 6);
		--0
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(48, 6);
		--5
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(53, 6);
		---
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(144, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(45, 6);
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(144, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(160, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);
		--D
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(160, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(176, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(4, 6);
		--I
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(176, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(9, 6);
		--L
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(208, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(12, 6);
		--&
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(240, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(38, 6);
		--S
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(19, 6);
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);	
		--K
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(11, 6);	
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);
		--Y
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(25, 6);	
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);	
		--N
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(368, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(14, 6);	
		--No Text
		else
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		end if;
	elsif game_mode = "010" or game_mode = "100" or game_mode = "110" then
		-- Display: Level X * Score: XX * Time: XX
		--L
		if (pixel_column_t >= CONV_STD_LOGIC_VECTOR(16, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(32, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(12, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(32, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(48, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		--V
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(48, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(64, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(22, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(64, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(80, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		--L
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(80, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(12, 6);
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		-- Level Number
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= level_num;
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(144, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		--*
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(144, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(160, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(42, 6);
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(160, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(176, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		--S
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(176, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(19, 6);
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(208, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--O
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(208, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(15, 6);
		--R
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(240, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(18, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(240, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);	
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);	
		--Tens Digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(284, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= tens;
		--Ones Digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(284, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(300, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= ones;	
		--
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(300, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(316, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);	
		--*
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(316, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(332, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(42, 6);
		--
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(332, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(348, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		--T
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(348, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(364, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(20, 6);
		--I
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(364, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(380, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(9, 6);
		--M
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(380, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(396, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(13, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(396, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(412, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);	
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(412, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(428, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);	
		--Tens Digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(428, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(444, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= time_tens;
		--Ones Digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(444, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(460, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= time_ones;
		--No Text
		else
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		end if;
	elsif game_mode = "001" then
		-- Display: PRACTICE
		--P
		if (pixel_column_t >= CONV_STD_LOGIC_VECTOR(16, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(32, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(16, 6);
		--R
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(32, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(48, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(18, 6);
		--A
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(48, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(64, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(1, 6);
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(64, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(80, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--T
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(80, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(20, 6);
		--I
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(9, 6);
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(144, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		--No Text
		else
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		end if;
	elsif game_mode = "011" OR game_mode = "101" then
		-- Display: Level END
		--S
		if (pixel_column_t >= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(157, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(19, 6);
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(160, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--O
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(15, 6);
		--R
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(18, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		-- Score Tens digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= tens;
		-- Score Ones digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= ones;
			
		--CONTINUE
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--O
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(272, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(15, 6);
		--N
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(14, 6);
		--T
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(304, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(20, 6);
		--I
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(9, 6);
		--N
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(336, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(14, 6);
		--U
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(368, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(21, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(368, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		
		--GAME SEL 1
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(240, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(41, 6);
		--GAME SEL 2
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(400, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(367, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(40, 6);
		--No Text
		else
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		end if;
	elsif game_mode = "111" then
		-- Display: Level END
		--S
		if (pixel_column_t >= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(157, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(19, 6);
		--C
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(160, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(3, 6);
		--O
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(192, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(15, 6);
		--R
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(224, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(18, 6);
		--E
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(5, 6);
		-- 
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		-- Score Tens digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(320, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= tens;
		-- Score Ones digit
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(352, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(384, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(127, 10)) then
			char_row <= pixel_row_t(4 downto 2);
			char_col <= pixel_column_t(4 downto 2);
			char_add <= ones;
		--No Text
		else
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		end if;
	end if;
	
end process TEXT_Display;

end behavior;