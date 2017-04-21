LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;

ENTITY tank IS
   PORT(SIGNAL RGB 						: OUT std_logic_vector(11 DOWNTO 0);
		SIGNAL pixel_row, pixel_column  : IN std_logic_vector(10 DOWNTO 0);
		SIGNAL game_mode				: IN std_logic_vector(2 DOWNTO 0);
        SIGNAL Horiz_sync, Vert_sync	: IN std_logic;
		SIGNAL Seed						: IN std_logic_vector(10 DOWNTO 0);
		SIGNAL left_button				: IN std_logic;
		SIGNAL mouse_col				: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL score					: OUT std_logic_vector(7 DOWNTO 0));		
END tank;

architecture behavior of tank is 
SIGNAL Tank_on, Player_on, Bullet_on		: std_logic := '0';
SIGNAL s_score								: std_logic_vector(7 DOWNTO 0) := X"00";
SIGNAL s_active								: std_logic := '0';
SIGNAL Bullet_Y_motion						: std_logic_vector(10 DOWNTO 0);
SIGNAL Bullet_Y_pos, Bullet_X_pos			: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(320, 11);
SIGNAL Size, Bullet_Size					: std_logic_vector(10 DOWNTO 0);  
SIGNAL Ball_X_motion						: std_logic_vector(10 DOWNTO 0);
SIGNAL Ball_Y_pos, Ball_X_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL Player_Y_pos, Player_X_pos			: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(320, 11);

BEGIN

Size <= CONV_STD_LOGIC_VECTOR(8,11);
Bullet_Size <= CONV_STD_LOGIC_VECTOR(4,11);
Ball_Y_pos <= CONV_STD_LOGIC_VECTOR(50,11);
Player_Y_pos <= CONV_STD_LOGIC_VECTOR(430, 11);

RGB(0) <= '1' AND NOT Player_on AND NOT Bullet_on;
RGB(1) <= '1' AND NOT Player_on AND NOT Bullet_on;
RGB(2) <= '1' AND NOT Player_on AND NOT Bullet_on;
RGB(3) <= '1' AND NOT Player_on AND NOT Bullet_on;
RGB(4) <= '1' AND NOT Tank_on AND NOT Bullet_on;
RGB(5) <= '1' AND NOT Tank_on AND NOT Bullet_on;
RGB(6) <= '1' AND NOT Tank_on AND NOT Bullet_on;
RGB(7) <= '1' AND NOT Tank_on AND NOT Bullet_on;
RGB(8) <= '1' AND NOT Tank_on AND NOT Player_on;
RGB(9) <= '1' AND NOT Tank_on AND NOT Player_on;
RGB(10) <= '1' AND NOT Tank_on AND NOT Player_on;
RGB(11) <= '1' AND NOT Tank_on AND NOT Player_on;

RGB_Display_Ball: Process (game_mode, Bullet_X_pos, Bullet_Y_pos, Player_X_pos, Player_Y_pos, Ball_X_pos, Ball_Y_pos, pixel_column, pixel_row, Size, Bullet_Size)
BEGIN
	IF game_mode = "001" OR game_mode = "010" OR game_mode = "100" OR game_mode = "110" THEN
		IF ('0' & Ball_X_pos <= pixel_column + Size) AND
		(Ball_X_pos + Size >= '0' & pixel_column) AND
		('0' & Ball_Y_pos <= pixel_row + Size) AND
		(Ball_Y_pos + Size >= '0' & pixel_row ) THEN
			Tank_on <= '1';
		ELSE
			Tank_on <= '0';
		END IF;
		
		IF ('0' & Player_X_pos <= pixel_column + Size) AND
		(Player_X_pos + Size >= '0' & pixel_column) AND
		('0' & Player_Y_pos <= pixel_row + Size) AND
		(Player_Y_pos + Size >= '0' & pixel_row ) THEN
			Player_on <= '1';
		ELSE
			Player_on <= '0';
		END IF;
		
		IF s_active = '1' AND
		('0' & Bullet_X_pos <= pixel_column + Bullet_Size) AND
		(Bullet_X_pos + Bullet_Size >= '0' & pixel_column) AND
		('0' & Bullet_Y_pos <= pixel_row + Bullet_Size) AND
		(Bullet_Y_pos + Bullet_Size >= '0' & pixel_row ) THEN
			Bullet_on <= '1';
		ELSE
			Bullet_on <= '0';
		END IF;
	END IF;
END process RGB_Display_Ball;

Move_Tank: process(vert_sync, game_mode)
BEGIN
	IF rising_edge(vert_sync) THEN
	
		IF game_mode = "000" THEN
			s_score <= X"00";
		END IF;
		
		IF game_mode = "000" OR game_mode = "011" OR game_mode = "101" OR game_mode = "111" THEN
			IF Seed >= (CONV_STD_LOGIC_VECTOR(640,11) - Size) THEN
				Ball_X_pos <= CONV_STD_LOGIC_VECTOR(640,11) - Size;
			ELSIF Seed <= Size THEN
				Ball_X_pos <= Size;
			ELSE
				Ball_X_pos <= Seed;
			END IF;
			
			IF Seed(5) = '1' THEN
				Ball_X_motion <= - CONV_STD_LOGIC_VECTOR(2,11);
			ELSE	
				Ball_X_motion <= CONV_STD_LOGIC_VECTOR(2,11);
			END IF;
			s_active <= '0';
			Player_X_pos <= CONV_STD_LOGIC_VECTOR(320, 11);
		ELSE
			-- टैंक 

			IF ('0' & Ball_X_pos) >= CONV_STD_LOGIC_VECTOR(640,11) - Size THEN
				Ball_X_motion <= - CONV_STD_LOGIC_VECTOR(1,11);
			ELSIF Ball_X_pos <= Size THEN
				Ball_X_motion <= CONV_STD_LOGIC_VECTOR(1,11);
			END IF;

			Ball_X_pos <= Ball_X_pos + Ball_X_motion;
			
			-- प्लेयर 
			
			IF ('0' & mouse_col) >= "0111000000" THEN
				Player_X_pos <= Player_X_pos + CONV_STD_LOGIC_VECTOR(2,11);
			ELSIF mouse_col <= "0100000000" THEN
				Player_X_pos <= Player_X_pos - CONV_STD_LOGIC_VECTOR(2,11);
			ELSE
				Player_X_pos <= Player_X_pos;
			END IF;
			
			-- बुलेट
			
			IF Bullet_Y_pos <= Bullet_Size THEN
				s_active <= '0';
			END IF;
			
			IF left_button = '1' AND s_active = '0' THEN
				s_active <= '1';
				Bullet_Y_pos <= Player_Y_pos;
				Bullet_X_pos <= Player_X_pos;
				Bullet_Y_motion <= - CONV_STD_LOGIC_VECTOR(3,11);
			END IF;
			
			IF s_active = '1' THEN
				Bullet_Y_pos <= Bullet_Y_pos + Bullet_Y_motion;
			END IF;
			
			-- कोल्लिसिओं
			
			IF ('0' & Ball_X_pos <= Bullet_X_pos + Size) AND
			(Ball_X_pos + Size >= '0' & Bullet_X_pos) AND
			('0' & Ball_Y_pos <= Bullet_Y_pos + Size) AND
			(Ball_Y_pos + Size >= '0' & Bullet_Y_pos ) THEN
				s_active <= '0';
				s_score <= s_score + '1';
				Bullet_Y_pos <= Player_Y_pos;
				Bullet_X_pos <= Player_X_pos;
				
				IF Seed >= (CONV_STD_LOGIC_VECTOR(640,11) - Size) THEN
					Ball_X_pos <= CONV_STD_LOGIC_VECTOR(640,11) - Size;
				ELSIF Seed <= Size THEN
					Ball_X_pos <= Size;
				ELSE
					Ball_X_pos <= Seed;
				END IF;
				
				IF Seed(5) = '1' THEN
					Ball_X_motion <= - CONV_STD_LOGIC_VECTOR(2,11);
				ELSE	
					Ball_X_motion <= CONV_STD_LOGIC_VECTOR(2,11);
				END IF;
			END IF;
		END IF;
	END IF;
END process Move_Tank;

score <= s_score;

END behavior;

