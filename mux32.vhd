library IEEE;
use IEEE.std_logic_1164.all;

-----------------------------------------------------

entity mux32 is
   PORT
   (
      r0_busin, r1_busin, r2_busin, r3_busin,
		r4_busin, r5_busin, r6_busin, r7_busin,
		r8_busin, r9_busin, r10_busin, r11_busin,
		r12_busin, r13_busin, r14_busin, r15_busin,
		hi_busin, lo_busin, zhi_busin, zlo_busin,
		pc_busin, mdr_busin: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(4 downto 0);
		
		muxout: out std_logic_vector(31 downto 0)
   );
END entity;

-----------------------------------------------------

architecture logic of mux32 is

begin

muxout <=	r0_busin 	when (sel = "00000")
		else	r1_busin		when (sel = "00001")
		else	r2_busin		when (sel = "00010")
		else	r3_busin		when (sel = "00011")
		else	r4_busin		when (sel = "00100")
		else	r5_busin		when (sel = "00101")
		else	r6_busin 	when (sel = "00110")
		else	r7_busin		when (sel = "00111")
		else	r8_busin		when (sel = "01000")
		else	r9_busin		when (sel = "01001")
		else	r10_busin	when (sel = "01010")
		else	r11_busin	when (sel = "01011")
		else	r12_busin	when (sel = "01100")
		else	r13_busin	when (sel = "01101")
		else	r14_busin	when (sel = "01110")
		else	r15_busin	when (sel = "01111")
		else	hi_busin		when (sel = "10000")
		else	lo_busin		when (sel = "10001")
		else	zhi_busin	when (sel = "10010")
		else	zlo_busin	when (sel = "10011")
		else	pc_busin		when (sel = "10100")
		else	mdr_busin	when (sel = "10101")
		else	(others => '0');
		
--		else	(others => '0')	when (sel = "10110")
--		else	(others => '0')	when (sel = "10111")
--		else	(others => '0')	when (sel = "11000")
--		else	(others => '0')	when (sel = "11001")
--		else	(others => '0')	when (sel = "11010")
--		else	(others => '0')	when (sel = "11011")
--		else	(others => '0')	when (sel = "11100")
--		else	(others => '0')	when (sel = "11101")
--		else	(others => '0')	when (sel = "11110")
--		else	(others => '0')	when (sel = "11111");
		
		
end architecture;