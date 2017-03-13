-- adder_datapath_tb.vhd file: <This is the filename>
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- entity declaration only; no definition here
ENTITY ELEC374_tb IS
END;
-- Architecture of the testbench with the signal names
ARCHITECTURE ELEC374_tb_arch OF ELEC374_tb IS -- Add any other signal you would like to see in your simulation
	 SIGNAL MARin_tb, 
			r0in_tb, r1in_tb, r2in_tb, r3in_tb, r4in_tb,
			r5in_tb, r6in_tb, r7in_tb, r8in_tb, r9in_tb,
			r10in_tb, r11in_tb, r12in_tb, r13in_tb, r14in_tb,
			r15in_tb, HIin_tb, LOin_tb, Zhighin_tb, Zlowin_tb,
			PCin_tb, IRin_tb, MDRin_tb, InPortin_tb, Cin_tb, Yin_tb: std_logic;
	 
	 SIGNAL MARout_tb, 
			r0out_tb, r1out_tb, r2out_tb, r3out_tb, r4out_tb,
			r5out_tb, r6out_tb, r7out_tb, r8out_tb, r9out_tb,
			r10out_tb, r11out_tb, r12out_tb, r13out_tb, r14out_tb,
			r15out_tb, HIout_tb, LOout_tb, Zhighout_tb, Zlowout_tb,
			PCout_tb, MDRout_tb, outPortout_tb, Cout_tb, Yout_tb: std_logic;
	 
	
	 SIGNAL IncPC_tb, read_sig_tb: std_logic;
	 SIGNAL ctrl_op_tb: std_logic_vector(3 downto 0);
	 SIGNAL Mdatain_tb, BusMuxOut_tb: std_logic_vector (31 downto 0);
	 SIGNAL Clock_tb,reset_tb: Std_logic;

	 TYPE State IS (default, Reg_load1, Reg_load2, Reg_load3, T0, T1, T2, T3, T4, T5);
	 SIGNAL Present_state: State := default;
	 -- component instantiation of the ELEC374
	 COMPONENT ELEC374
		 PORT (
			MARin, 
			r0in, r1in, r2in, r3in, r4in,
			r5in, r6in, r7in, r8in, r9in,
			r10in, r11in, r12in, r13in, r14in,
			r15in, HIin, LOin, Zhighin, Zlowin,
			PCin, IRin, MDRin, InPortin, Cin, Yin: in std_logic;
			
			MARout, 
			r0out, r1out, r2out, r3out, r4out,
			r5out, r6out, r7out, r8out, r9out,
			r10out, r11out, r12out, r13out, r14out,
			r15out, HIout, LOout, Zhighout, Zlowout,
			PCout, MDRout, outPortout, Cout, Yout: in std_logic;
			
			IncPC, read_sig : in std_logic;
			
			ctrl_op : in std_logic_vector(3 downto 0);
			Mdatain : in std_logic_vector(31 downto 0);
			clk, reset: in std_logic;
			BusOut: out std_logic_vector(31 downto 0)
			
			);
	 END COMPONENT ELEC374;
	BEGIN
	 DUT : ELEC374
	--port mapping: between the dut and the testbench signals
	 PORT MAP (		
		MARin => MARin_tb,
		R0in => R0in_tb,
		R1in => R1in_tb,
		R2in => R2in_tb,
		R3in => R3in_tb,
		R4in => R4in_tb,
		R5in => R5in_tb,
		R6in => R6in_tb,
		R7in => R7in_tb,
		R8in => R8in_tb,
		R9in => R9in_tb,
		R10in => R10in_tb,
		R11in => R11in_tb,
		R12in => R12in_tb,
		R13in => R13in_tb,
		R14in => R14in_tb,
		R15in => R15in_tb,
		HIin => HIin_tb,
		LOin => LOin_tb,
		Zhighin => Zhighin_tb,
		Zlowin => Zlowin_tb,
		PCin => PCin_tb,
		IRin => IRin_tb,
		MDRin => MDRin_tb,
		InPortin => InPortin_tb,
		Cin => Cin_tb,
		Yin => Yin_tb,
		
		
		MARout => MARout_tb,
		R0out => R0out_tb,
		R1out => R1out_tb,
		R2out => R2out_tb,
		R3out => R3out_tb,
		R4out => R4out_tb,
		R5out => R5out_tb,
		R6out => R6out_tb,
		R7out => R7out_tb,
		R8out => R8out_tb,
		R9out => R9out_tb,
		R10out => R10out_tb,
		R11out => R11out_tb,
		R12out => R12out_tb,
		R13out => R13out_tb,
		R14out => R14out_tb,
		R15out => R15out_tb,
		HIout => HIout_tb,
		LOout => LOout_tb,
		Zhighout => Zhighout_tb,
		Zlowout => Zlowout_tb,
		PCout => PCout_tb,
		--IRout => IRout_tb,
		MDRout => MDRout_tb,
		outPortout => outPortout_tb,
		Cout => Cout_tb,
		Yout => Yout_tb,
		
		IncPC => IncPC_tb,
		read_sig => read_sig_tb,
		ctrl_op => ctrl_op_tb,
		Mdatain => Mdatain_tb,
		BusOut => BusMuxOut_tb,
		clk => Clock_tb,
		reset => reset_tb
		);
	--add test logic here
	Clock_process: PROCESS
	BEGIN
		Clock_tb <= '1';
		Wait for 10 ns;
		Clock_tb <= '0';
		Wait for 20 ns;
	END PROCESS Clock_process;
	PROCESS (Clock_tb) -- finite state machine
		BEGIN
		IF (Clock_tb'EVENT AND Clock_tb = '1') THEN -- if clock rising-edge
			CASE Present_state IS
				WHEN Default =>
					Present_state <= Reg_load1;
				WHEN Reg_load1 =>
					Present_state <= Reg_load2;
				WHEN Reg_load2 =>
					Present_state <= Reg_load3;
				WHEN Reg_load3 =>
					Present_state <= T0;
				WHEN T0 =>
					Present_state <= T1;
				WHEN T1 =>
					Present_state <= T2;
				WHEN T2 =>
					Present_state <= T3;
				WHEN T3 =>
					Present_state <= T4;
				WHEN T4 =>
					Present_state <= T5;
				WHEN OTHERS =>
			END CASE;
		END IF;
	END PROCESS;
	PROCESS (Present_state) -- do the required job in each state
		BEGIN
		CASE Present_state IS -- assert the required signals in each clock cycle
			WHEN Default =>
				PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
				R2out_tb <= '0'; R3out_tb <= '0'; MARin_tb <= '0'; Zlowin_tb <= '0';
				PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0';
				R1in_tb <= '0'; IncPC_tb <= '0'; read_sig_tb <= '0'; ctrl_op_tb <= "0011";
			WHEN Reg_load1 =>
				Mdatain_tb <= x"00000012";
				read_sig_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				MDRin_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				MDRout_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				R1in_tb <= '0', '1' after 10 ns;
			WHEN Reg_load2 =>
				Mdatain_tb <= x"00000007" after 10 ns;
				read_sig_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				MDRin_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				MDRout_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				R2in_tb <= '0', '1' after 10 ns;
			WHEN Reg_load3 =>
				Mdatain_tb <= x"00000004" after 10 ns;
				read_sig_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				MDRin_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				MDRout_tb <= '0', '1' after 10 ns, '0' after 20 ns;
				R3in_tb <= '0', '1' after 10 ns;

			WHEN T0 =>
				PCout_tb <= '1'; MARin_tb <= '1'; IncPC_tb <= '1'; Zlowin_tb <= '1';
			WHEN T1 =>
				Zlowout_tb <= '1'; PCin_tb <= '1'; read_sig_tb <= '1'; MDRin_tb <= '1';
				Mdatain_tb(31 downto 0) <= x"294c0000"; -- opcode for add R1, R2, R3
			WHEN T2 =>
				MDRout_tb <= '1'; IRin_tb <= '1';
			WHEN T3 =>
				R2out_tb <= '1'; Yin_tb <= '1';
			WHEN T4 =>
				ctrl_op_tb <= "0011"; Zlowin_tb <= '1';
			WHEN T5 =>
				Zlowout_tb <= '1'; R1in_tb <= '1';
			WHEN OTHERS =>
		END CASE;
	END PROCESS;
END ARCHITECTURE ELEC374_tb_arch;