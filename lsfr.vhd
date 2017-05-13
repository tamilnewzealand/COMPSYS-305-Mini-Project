library ieee;
    use ieee.std_logic_1164.all;

--Generate random seed for AI tanks
entity lfsr is
  port (cout   :out std_logic_vector (10 downto 0);
		enable :in  std_logic;
		clk    :in  std_logic);
end entity;

architecture rtl of lfsr is
    signal count : std_logic_vector (10 downto 0) := "01100101010"; --Initial value

begin
    process (clk) 
	begin
        if rising_edge(clk) then
            if enable = '1' then --Random seed generation through very difficult to predict function
                count <= '0' & count(8) & (not(count(7) xor count(3)) & not(count(5) xor count(1)) & count(5)
						  & not(count(3) xor count(8)) & count(3) & count(2) & (count(4) xor count(6))
						  & count(0) & count(9));
            end if;
        end if;
    end process;
	
    cout <= count;
end architecture;