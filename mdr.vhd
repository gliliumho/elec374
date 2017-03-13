library IEEE;
use IEEE.std_logic_1164.all;

use work.my_components.all;


entity mdr is
   port
   (
      clk, clear, Read_sel, MDRin: in std_logic;
		BusMuxOut, Mdatain: in std_logic_vector(31 downto 0);

		BusMuxIn: out std_logic_vector(31 downto 0)
   );
end entity;

-----------------------------------------------------

architecture mem_reg of MDR is

signal mux_to_reg : std_logic_vector(31 downto 0);

begin

mux_to_reg <= BusMuxOut when Read_sel = '0'
		else Mdatain;

mem_data_reg : reg32
	port map (
		--encoder_in => x_in,
		clk	=>	clk,
		reset_n => '0', -- Fix this later 11111111111111111111111111111111111111
		en => MDRin,
		d => mux_to_reg,
      q 	=> BusMuxIn
	);

end architecture;
