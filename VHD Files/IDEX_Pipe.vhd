library ieee;
use ieee.std_logic_1164.all;

entity IDEX_Pipe is
	port(
		i_RegDst, i_ALUSrc, i_Branch, i_MemRead, i_MemWrite, i_RegWrite, i_MemtoReg		 : in std_logic;
		o_RegDst, o_ALUSrc, o_Branch, o_MemRead, o_MemWrite, o_RegWrite, o_MemtoReg		 : out std_logic;
		GReset, Gclock																	 : in std_logic;

		i_PC, i_signExtendedOffset  : in std_logic_vector(31 downto 0);
		i_readData1, i_readData2	: in std_logic_vector(7 downto 0);
		i_rt, i_rd				    : in std_logic_vector(7 downto 0);

		o_PC, o_signExtendedOffset  : out std_logic_vector(31 downto 0);
		o_readData1, o_readData2	: out std_logic_vector(7 downto 0);
		o_rt, o_rd				    : out std_logic_vector(7 downto 0)
	);
end IDEX_Pipe;

architecture structural of IDEX_Pipe is
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
			i_d	      	=> i_RegDst,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_RegDst,
			o_qBar	 	=> open 
		);

	control_dFF1: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	      	=> i_ALUSrc,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_ALUSrc,
			o_qBar	 	=> open 
		);
	
	control_dFF2: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	      	=> i_Branch,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_Branch,
			o_qBar	 	=> open 
		);
	
	control_dFF3: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	      	=> i_MemRead,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_MemRead,
			o_qBar	 	=> open 
		);

	control_dFF4: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	      	=> i_MemWrite,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_MemWrite,
			o_qBar	 	=> open 
		);
	
	control_dFF5: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	      	=> i_RegWrite,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_RegWrite,
			o_qBar	 	=> open 
		);
	
	control_dFF6: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	      	=> i_MemtoReg,
			i_enable 	=>	'1',
			i_clock  	=> Gclock, 
			o_q      	=> o_MemtoReg,
			o_qBar	 	=> open 
		);
	
	-- ===== Pipeline Values =====
	PC_gen: for i in 0 to 31 generate
		begin
		dFF_inst: enARdFF_2
			port map(
				i_resetBar	=> GReset,
				i_d	     => i_PC(i),
				i_enable =>	'1',
				i_clock  => Gclock, 
				o_q      => o_PC(i),
				o_qBar	 => open 	
			);
    end generate;

	signExtension_gen: for i in 0 to 31 generate
		begin
		dFF_inst: enARdFF_2
			port map(
				i_resetBar	=> GReset,
				i_d	     => i_signExtendedOffset(i),
				i_enable =>	'1',
				i_clock  => Gclock, 
				o_q      => o_signExtendedOffset(i),
				o_qBar	 => open 	
			);
	end generate;

	readData1_gen: for i in 0 to 7 generate
	begin
	dFF_inst: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_readData1(i),
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_readData1(i),
			o_qBar	 => open 	
		);
	end generate;

	readData2_gen: for i in 0 to 7 generate
	begin
	dFF_inst: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_readData2(i),
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_readData2(i),
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

	rd_gen: for i in 0 to 7 generate
	begin
	dFF_inst: enARdFF_2
		port map(
			i_resetBar	=> GReset,
			i_d	     => i_rd(i),
			i_enable =>	'1',
			i_clock  => Gclock, 
			o_q      => o_rd(i),
			o_qBar	 => open 	
		);
	end generate;
	
end structural;

