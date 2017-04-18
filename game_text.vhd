LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY game_text IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);
   PORT(signal sw0							: in std_logic;
		  signal pixel_column, pixel_row	: in std_logic_vector(9 downto 0);
		  signal game_mode					: in std_logic_vector(1 downto 0);
		  signal char_add					: out std_logic_vector(5 downto 0);
		  signal char_row, char_col			: out std_logic_vector(2 downto 0));
end game_text;

architecture behavior of game_text is

-- Video Display Signals   
signal pixel_row_t, pixel_column_t		: std_logic_vector(9 downto 0);

begin           

pixel_column_t <= pixel_column;
pixel_row_t <= pixel_row;

TEXT_Display: process (pixel_column_t, pixel_row_t, sw0)
begin
	-- माईन मेनू स्क्रीन
	if game_mode = "00" then
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
		--X
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(96, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(24, 6);
		--X
		elsif (pixel_column_t >= CONV_STD_LOGIC_VECTOR(112, 10)) and
			(pixel_column_t <= CONV_STD_LOGIC_VECTOR(128, 10)) and
			(pixel_row_t >= CONV_STD_LOGIC_VECTOR(464, 10)) and
			(pixel_row_t <= CONV_STD_LOGIC_VECTOR(480, 10)) then
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(24, 6);
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
	-- प्रैक्टिस स्क्रीन
	elsif game_mode = "10" then
		--PRACTICE
		--P
		if (pixel_column_t >= CONV_STD_LOGIC_VECTOR(256, 10)) and
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
		--No Text
		else
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		end if;
	-- गेम स्क्रीन
	elsif game_mode = "11" then
		--GAME	
		--G
		if (pixel_column_t >= CONV_STD_LOGIC_VECTOR(288, 10)) and
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
		--No Text
		else
			char_row <= pixel_row_t(3 downto 1);
			char_col <= pixel_column_t(3 downto 1);
			char_add <= CONV_STD_LOGIC_VECTOR(32, 6);
		end if;
	end if;
end process TEXT_Display;

end behavior;