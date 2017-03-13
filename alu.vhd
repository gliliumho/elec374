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
signal add_result,sub_result: std_logic_vector(31 downto 0);
signal div_result, mul_result: std_logic_vector(63 downto 0);



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

component alu_add_sub
	PORT
	(
		add_sub		: IN STD_LOGIC ;
		dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;

component alu_div
	PORT
	(
		denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;

component booth_mult 
	port(
		M, Q : in std_logic_vector(31 downto 0);
		P_final : out std_logic_vector(63 downto 0)
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
			cout => cout
	);

ADD : alu_add_sub port map (		
		add_sub		=>'1',
		dataa		=>regA,
		datab		=>regB,
		result		=>	add_result	
	);
	
SUB : alu_add_sub port map (	
		add_sub		=>	'0',
		dataa		=>	regA,
		datab		=>	regB,
		result		=>	sub_result	
	);
	
DIV : alu_div port map (
		denom		=>	regB,
		numer		=>	regA,
		quotient	=>	div_result(63 downto 32),
		remain	=>	div_result(31 downto 0)
	);	
	
MUL : booth_mult port map (
		M			=>	regA,
		Q			=>	regB,
		P_final 	=>	mul_result
	);
	
	
process (sel,regA,regB)
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
	elsif sel="1000" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= add_result;
	elsif sel="1001" then
		regC(63 downto 32) <= (others => '0');
		regC(31 downto 0) <= sub_result;
	--Sub using megafunction
	
	elsif sel="1010" then
		regC <= mul_result;
	--Multiply using array multiplier
		
	elsif sel="1011" then
		regC <= div_result;
	--Divide using built in
	
	elsif sel="1100" then
		regC(63 downto 16) <= (others => '0');
		regC(15 downto 0) <= cla_result;
	else
		regC <= (others => '0');
	end if;
end process;

end architecture;
