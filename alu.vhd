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
signal cla_result: std_logic_vector(15 downto 0);


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

CLA : cla_16bit port map (
			x => regA(15 downto 0),
			y => regB(15 downto 0),
			cin => '0',

			sum => cla_result,
			gout => g,
			pout => p,
			cout => cout);

process(P)
	begin
	if sel="0000" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= regA and regB;
	elsif sel="0001" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= regA or regB;
	elsif sel="0010" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= not(regB);
	elsif sel="0011" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= '0' & regB(31 downto 1);
	elsif sel="0100" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= regB(30 downto 0) & '0';
	elsif sel="0101" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= std_logic_vector(unsigned(not(regB)) + 1); -- might not need quotes
	elsif sel="0110" then
	--rotate right
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= regB(0) & regB(31 downto 1);
	elsif sel="0111" then
	--rotate left
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <=regB(30 downto 0) & regB(31);
	--elsif sel="1000" then
		--regC <= regA + regB;
		--Add using megafunction
	--elsif sel="1001" then
		--regC <= regA +neg(regB);
	--Sub using megafunction
	--elsif sel="1010" then
		--null;
	--Multiply using array multiplier
	--elsif sel="1011" then
		--NULL;
	--Divide using built in
	elsif sel="1100" then
		regC(63 downto 16) <= (others => '0');
		regC(15 downto 0) <= cla_result;

	end if;
end process;

end architecture;
