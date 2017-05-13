library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

--Manages the overflows for the counters
entity counterOverflow is
   port(Data_In1, Data_In2 : in std_logic_vector(0 to 3);
        Enable, Reset : in std_logic;
        Data_Out1, Data_Out2 : out std_logic_vector(0 to 3);
        Enable2, Reset2 : out std_logic);
end counterOverflow;
 
 
architecture beh of counterOverflow is
begin
  process(Reset, Data_In1, Data_In2, Enable)
  begin
    Data_Out1 <= Data_In1;
    Data_Out2 <= Data_In2;
    
    if(Reset = '1') then --When low counter is reset, reset high counter too
      Reset2 <= '1';
    elsif(Data_In2 = "1001" AND Data_In1 = "1001") then --Reset High counter when time is at 99
      Reset2 <= '1';
    else
      Reset2 <= '0';
    end if;

    if(Enable = '1') then
      if(Data_In1 = "0000") then
        Enable2 <= '1'; --Enable countdown for high counter when low counter reaches zero
      else
        Enable2 <= '0';
      end if;
    else
      Enable2 <= '0';
    end if;
    
  end process;
end beh;