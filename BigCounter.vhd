library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--Counter to calculate time remaining so it can be displayed later
entity BigCounter is
   port(game_mode 	  : in std_logic_vector(2 downto 0);
		clock, Clk	  : in std_logic;
		sw9			  : in std_logic;
        Low_Q, High_Q : out std_logic_vector(0 to 3);
		game_end	  : out std_logic);
end BigCounter;
 
 
architecture beh of BigCounter is
signal Enable : std_logic;
signal Reset : std_logic;
signal Direction : std_logic := '1'; --Direction of counting
signal EnableTwo : std_logic; --Enable for high counter
signal ResetTwo : std_logic; --Reset for high counter
signal S_Low_Q, S_High_Q : std_logic_vector(0 to 3); --Output time for high and low times

--BigCounter uses BCDCounter
component BCDCounter
  port( Enable, Clk, Init, Direction : in std_logic;
        Q_Out : out std_logic_vector(0 to 3));
end component;

--and counterOverflow components
component counterOverflow
  port( Data_In1, Data_In2 : in std_logic_vector(0 to 3);
        Data_Out1, Data_Out2 : out std_logic_vector(0 to 3);
        Enable, Reset : in std_logic;
        Enable2, Reset2 : out std_logic);
end component;
begin

--Port mapping to BCDCounter for the low counter
LowCounter : BCDCounter port map (
		Enable => Enable,
		Clk => Clk,
		Init => Reset,
		Direction => Direction,
		Q_Out => S_Low_Q		
);

--Port mapping to BCDCounter for high counter
HighCounter : BCDCounter port map (
		Enable => EnableTwo,
		Clk => Clk,
		Init => ResetTwo,
		Direction => Direction,
		Q_Out => S_High_Q		
);

--Port mapping to counterOverflow for overflow management
Overflow : counterOverflow port map (
		Data_In1 => S_Low_Q,
		Data_In2 => S_High_Q,
		Enable => Enable,
		Reset => Reset,
		Enable2 => EnableTwo,
		Reset2 => ResetTwo,
		Data_Out1 => Low_Q, --Final low time is from Overflow here
		Data_Out2 => High_Q --Final high time is from Overflow here
);

process(clock)
	variable oldMode : std_logic_vector(2 downto 0) := "000";
begin
	if rising_edge(clock) then
		Direction <= '1';
		if game_mode = "000" OR game_mode = "011" OR game_mode = "101" OR game_mode = "111" then -- If menu screen
			Reset <= '1'; --Reset the counter
			Enable <= '0'; --Stop Counter from counting
		else --If it isnt a menu screen
			Reset <= '0'; --Don't reset
			Enable <= '1'; --Continue Counting
		end if;
		
		if S_High_Q = "0000" AND S_Low_Q = "0000" then
			game_end <= '0'; --End game when counters reach 0
		else
			game_end <= '1';
		end if;
		
		if sw9 = '1' then
			Enable <= '0';
		end if;
	end if;
end process;
end beh;