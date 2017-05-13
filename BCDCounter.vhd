library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--Counter which keeps track of the time remaining
entity BCDCounter is
   port(Enable, Clk, Init, Direction : in std_logic;
 		    Q_Out : out std_logic_vector(0 to 3));
end BCDCounter;

 
architecture beh of BCDCounter is
signal temp: std_logic_vector(0 to 3);
begin
	process(Clk)
	variable oldDirection : std_logic;
	begin
    if(rising_edge(Clk)) then
      if Init = '1' then --If reset signal is received
        if Direction = '1' then --If counting downwards
          temp <= "1001"; -- Reset to value of 9 to get 99 seconds when both high and low are reset
        else
          temp <= "0000";
        end if;
      elsif(Direction /= oldDirection) then --When direction is changed reset
        if(Direction = '1') then
          temp <= "1001";
        else
          temp <= "0000";
        end if;
        oldDirection := Direction;
      elsif(Enable = '1') then
        if Direction = '1' then --If counting downwards
          if temp = "0000" then
            temp <= "1001";
          else
            temp <= temp - 1; --Reduce a second
          end if;
        else
          if(temp = "1001") then
            temp <= "0000";
          else
            temp <= temp + 1; --Increase a second
          end if;
        end if;
      end if;
    end if;
  end process;
  Q_Out <= temp; --Assign to output
end beh;
