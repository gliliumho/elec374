library IEEE;
use IEEE.std_logic_1164.all;
use work.my_components.all;


entity ELEC374 is
	port (

	--Cout, Zlowout, MDRout, R2out, R3out : out std_logic;

	MARin, Zin,
	r0in, r1in, r2in, r3in, r4in,
	r5in, r6in, r7in, r8in, r9in,
	r10in, r11in, r12in, r13in, r14in,
	r15in, HIin, LOin, Zhighin, Zlowin,
	PCin, MDRin, InPortin, Cin, Yin: in std_logic;

	MARout, Zout,
	r0out, r1out, r2out, r3out, r4out,
	r5out, r6out, r7out, r8out, r9out,
	r10out, r11out, r12out, r13out, r14out,
	r15out, HIout, LOout, Zhighout, Zlowout,
	PCout, MDRout, outPortout, Cout, Yout: in std_logic;
	IncPC, read_sig : in std_logic;

	ctrl_op : in std_logic_vector(3 downto 0);
	Mdatain : in std_logic_vector(31 downto 0);
	clk, reset: in std_logic

	);
end entity;

architecture structure of ELEC374 is


signal 	r0_toBus, r1_toBus, r2_toBus, r3_toBus,
		r4_toBus, r5_toBus, r6_toBus, r7_toBus,
		r8_toBus, r9_toBus, r10_toBus, r11_toBus,
		r12_toBus, r13_toBus, r14_toBus, r15_toBus,
		hi_toBus, lo_toBus, zhi_toBus, zlo_toBus,
		pc_toBus, mdr_toBus: std_logic_vector(31 downto 0);

signal bus_out: std_logic_vector(31 downto 0);

--signal	r0in, r1in, r2in, r3in, r4in,
	--	r5in, r6in, r7in, r8in, r9in,
		--r10in, r11in, r12in, r13in, r14in,
		--r15in, HIin, LOin, Zhighin, Zlowin,
		--PCin, MDRin, InPortin, Cin: std_logic;

signal y_toALU: std_logic_vector(31 downto 0);
signal alu_toZ: std_logic_vector(63 downto 0);


begin



reg0x : reg32 port map (clk, reset, r0in, bus_out, r0_toBus);
reg1x : reg32 port map (clk, reset, r1in, bus_out, r1_toBus);
reg2x : reg32 port map (clk, reset, r2in, bus_out, r2_toBus);
reg3x : reg32 port map (clk, reset, r3in, bus_out, r3_toBus);
reg4x : reg32 port map (clk, reset, r4in, bus_out, r4_toBus);
reg5x : reg32 port map (clk, reset, r5in, bus_out, r5_toBus);
reg6x : reg32 port map (clk, reset, r6in, bus_out, r6_toBus);
reg7x : reg32 port map (clk, reset, r7in, bus_out, r7_toBus);
reg8x : reg32 port map (clk, reset, r8in, bus_out, r8_toBus);
reg9x : reg32 port map (clk, reset, r9in, bus_out, r9_toBus);
reg10x : reg32 port map (clk, reset, r10in, bus_out, r10_toBus);
reg11x : reg32 port map (clk, reset, r11in, bus_out, r11_toBus);
reg12x : reg32 port map (clk, reset, r12in, bus_out, r12_toBus);
reg13x : reg32 port map (clk, reset, r13in, bus_out, r13_toBus);
reg14x : reg32 port map (clk, reset, r14in, bus_out, r14_toBus);
reg15x : reg32 port map (clk, reset, r15in, bus_out, r15_toBus);

regHIx : reg32 port map (clk, reset, HIin, bus_out, hi_toBus);
regLOx : reg32 port map (clk, reset, LOin, bus_out, lo_toBus);
regZhighx : reg32 port map (clk, reset, Zhighin, bus_out, zhi_toBus);
regZlowx : reg32 port map (clk, reset, Zlowin, bus_out, zlo_toBus);

regPCx : reg32 port map (clk, reset, PCin, bus_out, pc_toBus);

regMDRx : mdr port map (clk, reset, read_sig, MDRin, bus_out, Mdatain, mdr_toBus);

regYx : reg32 port map (clk, reset, Yin, bus_out, y_toALU);


ALUnit : alu port map (y_toALU, bus_out, ctrl_op, alu_toZ);

Bus_lane : bidir_bus
port map (
	r0_toBus, r1_toBus, r2_toBus, r3_toBus,
	r4_toBus, r5_toBus, r6_toBus, r7_toBus,
	r8_toBus, r9_toBus, r10_toBus, r11_toBus,
	r12_toBus, r13_toBus, r14_toBus, r15_toBus,
	hi_toBus, lo_toBus, zhi_toBus, zlo_toBus,
	pc_toBus, mdr_toBus,

	r0out,r1out,r2out,r3out,r4out,
	r5out,r6out,r7out,r8out,r9out,
	r10out,r11out,r12out,r13out,r14out,
	r15out,HIout,LOout,Zhighout,Zlowout,
	PCout, MDRout, outPortout, Cout,

	BusMuxOut => bus_out
);

end architecture;
