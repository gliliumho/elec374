library IEEE;
use IEEE.std_logic_1164.all;

use work.my_components.all;


entity bidir_bus is
   PORT
   (
      r0_busin, r1_busin, r2_busin, r3_busin,
		r4_busin, r5_busin, r6_busin, r7_busin,
		r8_busin, r9_busin, r10_busin, r11_busin,
		r12_busin, r13_busin, r14_busin, r15_busin,
		hi_busin, lo_busin, zhi_busin, zlo_busin,
		pc_busin, mdr_busin: in std_logic_vector(31 downto 0);
		
		r0out,r1out,r2out,r3out,r4out,
		r5out,r6out,r7out,r8out,r9out,
		r10out,r11out,r12out,r13out,r14out,
		r15out,HIout,LOout,Zhighout,Zlowout,
		PCout, MDRout, InPortout, Cout: in std_logic;
		
		BusMuxOut: out std_logic_vector(31 downto 0)
   );
END entity;

-----------------------------------------------------

architecture synth of bidir_bus is

signal encoder_to_mux : std_logic_vector(4 downto 0);

begin

the_encoder : encoder_32to5
	port map (
		--encoder_in => x_in,
		r0out		=>	r0out,
		r1out		=>	r1out,
		r2out		=>	r2out,
		r3out		=>	r3out,
		r4out		=>	r4out,
		r5out		=>	r5out,
		r6out		=>	r6out,
		r7out		=>	r7out,
		r8out		=>	r8out,
		r9out		=>	r9out,
		r10out	=>	r10out,
		r11out	=>	r11out,
		r12out	=>	r12out,
		r13out	=>	r13out,
		r14out	=>	r14out,
		r15out	=>	r15out,
		HIout		=>	HIout,
		LOout		=>	LOout,
		Zhighout	=>	Zhighout,
		Zlowout	=>	Zlowout,
		PCout		=>	PCout,
		MDRout	=>	MDRout,
		InPortout=>	InPortout,
		Cout		=>	Cout,
		y_out 	=> encoder_to_mux
	);
	
the_mux : mux32
	port map (
	--change port names to rN to rNx
		r0_busin 	=> r0_busin,
		r1_busin		=> r1_busin,
		r2_busin		=> r2_busin,
		r3_busin		=> r3_busin,
		r4_busin		=> r4_busin,
		r5_busin		=> r5_busin,
		r6_busin 	=> r6_busin,
		r7_busin		=> r7_busin,
		r8_busin		=> r8_busin,
		r9_busin		=> r9_busin,
		r10_busin	=>	r10_busin,
		r11_busin	=>	r11_busin,
		r12_busin	=>	r12_busin,
		r13_busin	=>	r13_busin,
		r14_busin	=>	r14_busin,
		r15_busin	=>	r15_busin,
		hi_busin		=>	hi_busin,
		lo_busin		=> lo_busin,
		zhi_busin	=> zhi_busin,
		zlo_busin	=> zlo_busin,
		pc_busin		=> pc_busin,
		mdr_busin	=> mdr_busin,
		sel 			=> encoder_to_mux,
		muxout		=> BusMuxOut
	);


--muxout	<= muxout;



end architecture;
