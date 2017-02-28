library IEEE;
use IEEE.std_logic_1164.all;

-----------------------------------------------------

entity reg32 is
   PORT
   (
      clk, reset_n, en: in STD_LOGIC;
		d : in STD_LOGIC_VECTOR(31 downto 0);
      q : out STD_LOGIC_VECTOR(31 downto 0)
   );
END entity;

-----------------------------------------------------

architecture logic of reg32 is

begin
	process(clk,reset_n, en)
		begin
			if reset_n = '1' then
				q <= (others=>'0');
			elsif(rising_edge(clk)) then
				if(en='1') then
					q<=d;
				end if;
			end if;
		end process;
end architecture;