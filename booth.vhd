library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity booth_mult is 
	port(
		M, Q : in std_logic_vector(31 downto 0);
		P_final : out std_logic_vector(63 downto 0)
	);
end entity;

architecture logic of booth_mult is
--length of M + length of Q + 1
	signal A, S, P, P_temp: std_logic_vector(64 downto 0);
	signal temp: std_logic_vector(31 downto 0);
begin
	A(64 downto 33) <= M;
	A(32 downto 0) <= (others => '0');


	temp <= std_logic_vector(unsigned(not(M)) + 1);
	S(64 downto 33) <= temp;
	S(32 downto 0) <= (others => '0');

	P(64 downto 33) <= (others => '0');
	P(32 downto 1) <= Q;
	P(0) <= '0';
	--perform number of steps equal to length of M and Q
	process (P)
	begin
	for i in 0 to 32 loop
	--check last 2 bits perform addition id needed, shift then place value in P
		case P(1 downto 0) is
			when "01" =>
				P_temp <= std_logic_vector(unsigned(P)+unsigned(A)); -- use the adder
				P_temp <= P_temp(64) & P_temp(64 downto 1);
			when "10" =>
				P_temp <= std_logic_vector(unsigned(P)+unsigned(S)); -- use adder
				P_temp <= P_temp(64) & P_temp(64 downto 1);
			when "00" =>
				P_temp <= P_temp(64) & P_temp(64 downto 1);
			when "11" =>
				P_temp <= P_temp(64) & P_temp(64 downto 1);
		end case;
		P <= P_temp;
	end loop;
	end process;
	--drop the LSB place product in output
	P_final <= P(64 downto 1);

end architecture;