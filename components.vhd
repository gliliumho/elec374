library IEEE;
use IEEE.std_logic_1164.all;

package my_components is

component reg32
   port
   (
      clk, reset_n, en: in std_logic;
      d : in std_logic_vector(31 downto 0);
      q : out std_logic_vector
   );
end component;


component reg64
   port
   (
      clk, reset_n, en: in std_logic;
      d : in std_logic_vector(63 downto 0);
      q : out std_logic_vector
   );
end component;


component encoder_32to5
   port
   (
      r0out,r1out,r2out,r3out,r4out,
      r5out,r6out,r7out,r8out,r9out,
      r10out,r11out,r12out,r13out,r14out,
      r15out,HIout,LOout,Zhighout,Zlowout,
      PCout, MDRout, InPortout, Cout: in std_logic;

      y_out: out std_logic_vector(4 downto 0)
   );
end component;


component mux32
   port
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
end component;


component bidir_bus
   port
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
end component;


component mdr
   port
   (
       clk, clear, Read_sel, MDRin: in std_logic;
       BusMuxOut, Mdatain: in std_logic_vector(31 downto 0);

       BusMuxIn: out std_logic_vector(31 downto 0)
   );
end component;


component alu
port
   (
	   regA, regB : in std_logic_vector(31 downto 0);
	   sel	: in std_logic_vector(3 downto 0);
	   regC : out std_logic_vector(63 downto 0)
   );
end component;


end package;
