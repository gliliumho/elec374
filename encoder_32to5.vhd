library IEEE;
use IEEE.std_logic_1164.all;

-----------------------------------------------------

entity encoder_32to5 is
   PORT
   (
      r0out,r1out,r2out,r3out,r4out,
		r5out,r6out,r7out,r8out,r9out,
		r10out,r11out,r12out,r13out,r14out,
		r15out,HIout,LOout,Zhighout,Zlowout,
		PCout, MDRout, InPortout, Cout: in std_logic;
			--CHANGE x_in to 32 separate inputs
		y_out: out std_logic_vector(4 downto 0)
   );
END entity;

-----------------------------------------------------

architecture behavior of encoder_32to5 is

begin

y_out <=		"00000" when (r0out = '1')
		else	"00001" when (r1out = '1')
		else	"00010" when (r2out = '1')
		else	"00011" when (r3out = '1')
		else	"00100" when (r4out = '1')
		else	"00101" when (r5out = '1')
		else	"00110" when (r6out = '1')
		else	"00111" when (r7out = '1')
		else	"01000" when (r8out = '1')
		else	"01001" when (r9out = '1')
		else	"01010" when (r10out = '1')
		else	"01011" when (r11out = '1')
		else	"01100" when (r12out = '1')
		else	"01101" when (r13out = '1')
		else	"01110" when (r14out = '1')
		else	"01111" when (r15out = '1')
		else	"10000" when (HIout = '1')
		else	"10001" when (LOout = '1')
		else	"10010" when (Zhighout = '1')
		else	"10011" when (Zlowout = '1')
		else	"10100" when (PCout = '1')
		else	"10101" when (MDRout = '1')
		else	"10110" when (InPortout = '1')
		else	"10111" when (Cout = '1')
		else	"11000";
		--else	"11000" when (r0out = '1')
		--else	"11001" when (r0out = '1')
		--else	"11010" when (r0out = '1')
		--else	"11011" when (r0out = '1')
		--else	"11100" when (r0out = '1')
		--else	"11101" when (r0out = '1')
		--else	"11110" when (r0out = '1')
		--else	"11111" when (r0out = '1');
		
		
end architecture;