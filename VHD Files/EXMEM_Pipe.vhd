library ieee;
use ieee.std_logic_1164.all;

entity EXMEM_Pipe is
	port(
		-- ===== Control Signals ===== 
		i_Branch, i_MemRead, i_MemWrite, i_RegWrite, i_MemtoReg : in std_logic;		
		o_Branch, o_MemRead, o_MemWrite, o_RegWrite, o_MemtoReg : out std_logic;
		Gclock, GReset											: in std_logic;		-- Other inputs for control signal flip flops.

		-- ===== Pipeline Values ===== 
		i_BTA, i_ALU_Result										: in std_logic_vector(31 downto 0);		
		i_zero													: in std_logic;
		i_rt, i_Rd												: in std_logic_vector(7 downto 0);
		
		o_BTA, o_ALU_Result										: out std_logic_vector(31 downto 0);
		o_zero													: out std_logic;
		o_rt, o_Rd												: out std_logic_vector(7 downto 0)
	);
end EXMEM_Pipe;

architecture structural of EXMEM_Pipe is
	component enARdFF_2 is 
		port(
			i_resetBar	: IN	STD_LOGIC;
			i_d			: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC
		);
	end component;

	begin
	-- ====== Control Signals ====== 
	control_dFF0: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	      	=> i_Branch,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_Branch,
			o_qBar	 	=> open 
		);
	
	control_dFF1: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_MemRead,
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_MemRead,
			o_qBar	 => open 	
		);

	control_dFF2: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_MemWrite,
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_MemWrite,
			o_qBar	 => open 	
		);
	
	control_dFF3: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_RegWrite,
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_RegWrite,
			o_qBar	 => open 	
		);
	
	control_dFF4: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_MemtoReg,
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_MemtoReg,
			o_qBar	 => open 	
		);
	
	-- ====== Pipeline Values ====== 
	BTA_gen: for i in 0 to 31 generate
		begin
		dFF_inst: enARdFF_2
			port map(
				i_resetBar	=> GReset,
				i_d	     => i_BTA(i),
				i_enable =>	'1',
				i_clock  => Gclock, 
				o_q      => o_BTA(i),
				o_qBar	 => open 	
			);
    end generate;
	
	zero_dFF: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_zero,
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_zero,
			o_qBar	 => open 	
		);

	ALU_Result_gen: for i in 0 to 31 generate
		begin
		dFF_inst: enARdFF_2
			port map(
				i_resetBar	=> GReset,
				i_d	     => i_ALU_Result(i),
				i_enable =>	'1',
				i_clock  => Gclock, 
				o_q      => o_ALU_Result(i),
				o_qBar	 => open 	
			);
    end generate;

	rt_gen: for i in 0 to 7 generate
		begin
		dFF_inst: enARdFF_2
			port map(
				i_resetBar	=> GReset,
				i_d	     => i_rt(i),
				i_enable =>	'1',
				i_clock  => Gclock, 
				o_q      => o_rt(i),
				o_qBar	 => open 	
			);
	end generate;

	Rd_gen: for i in 0 to 7 generate
		begin
		dFF_inst: enARdFF_2
			port map(
				i_resetBar	=> GReset,
				i_d	     => i_Rd(i),
				i_enable =>	'1',
				i_clock  => Gclock, 
				o_q      => o_Rd(i),
				o_qBar	 => open 	
			);
	end generate;

end structural;