library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
 
--A clock divider for BigCounter 
entity myClockDivider is
    port ( clk : in std_logic;
         clk_out : out std_logic);
end myClockDivider;
 
 
architecture beh of myClockDivider is
    signal count: std_logic_vector(0 to 27) := X"0000000"; --Initialise to zero
    signal tmp : std_logic := '0'; --Initialise temp to 0
begin
    process(clk)
    begin
        if(rising_edge(Clk)) then
            count <= count + 1;
            if count = X"17D7840" then --25MHz then reset to 0
                count <= X"0000000";
                tmp <= NOT tmp; --Changes every half second so that you have two temp(clock) events every second
            end if;
        end if;
    end process;
    clk_out <= tmp;
end beh;