--aaaaaaaaaaaaaaaaaaaaaaaaaaaaa

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is 
	PORT(
	--A, B, select inputs
	regA, regB : in std_logic_vector(31 downto 0);
	sel : in std_logic_vector(3 downto 0);
	regC : out std_logic_vector(63 downto 0)
	-- 1 level of 8x8 then add them together
	-- C output
	-- 1 architecture for the 12 instructions
	-- 1 for booth
	-- 1 for cary lookahead
	--32 bit reg Y to store A
	);
end entity;

architecture behaviour of alu is

signal g,p,cout: std_logic;

component cla_16bit
	port
		(
		 x   : in std_logic_vector(15 downto 0);
		 y   : in std_logic_vector(15 downto 0);
		 cin : in std_logic;

		 sum : out std_logic_vector(15 downto 0);
		 gout: out std_logic;
		 pout: out std_logic;
		 cout: out std_logic
		);
	end component;

begin
process (sel)
	begin
		case sel is 
			when "0000" => 
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <= regA and regB;
			when "0001" => 
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <= regA or regB;
			when "0010" => 
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <= not(regB);
			when "0011" => 
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <= '0' & regB(31 downto 1);
			when "0100" => 
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <= regB(30 downto 0) & '0';
			when "0101" => 
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <= std_logic_vector(unsigned(not(regB)) + 1); -- might not need quotes
			when "0110" => 
			--rotate right
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <= regB(0) & regB(31 downto 1);
			when "0111" => 
			--rotate left
				regC(63 downto 32) <= (others => '0');
				regC(31 downto 0) <=regB(30 downto 0) & regB(31);
			--when "1000" => 
				--regC <= regA + regB;
				--Add using megafunction
			--when "1001" => 
				--regC <= regA +neg(regB)
				--Sub using megafunction
			--when "1010" => 
				--Multiply using array multiplier
			--when "1011" => 
				--Divide using built in 
			--when "1100" => 
				--CLA : cla_16bit
				--port map (
				--	x => regA(15 downto 0),
				--	y => regB(15 downto 0), 
				--	cin => '0',
					
				--	sum => regC(15 downto 0),
				--	gout => g,
				--	pout => p,
				--	cout => c
				--);
			when others =>
				null;
		end case;
end process; 
end architecture;

