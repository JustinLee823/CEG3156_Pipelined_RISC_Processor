library ieee;
use ieee.std_logic_1164.all;

entity IDEX_Pipe is
	port(ReadData1, ReadData2 : in std_logic_vector(7 downto 0);
		RS, RT, RD : in std_logic_vector(4 downto 0);
		Instruction15_0 : in std_logic_vector(15 downto 0);
		i_ALUOp : in std_logic_vector(1 downto 0);
		i_RegDst, i_Branch, i_MemRead, i_MemtoReg, i_MemWrite, i_RegWrite, i_ALUSrc, i_Jump, i_clk, i_reset : in std_logic;
		o_ReadData1, o_ReadData2 : out std_logic_vector(7 downto 0);
		o_RS, o_RT, o_RD : out std_logic_vector(4 downto 0);
		o_Instruction15_0 : out std_logic_vector(15 downto 0);
		o_RegDst, o_Branch, o_MemRead, o_MemtoReg, o_MemWrite, o_RegWrite, o_ALUSrc, o_Jump : out std_logic;
		o_ALUOp : out std_logic_vector(1 downto 0));
end entity;

architecture rtl of IDEX_Pipe is
	component enARdFF_2
		port(i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	end component;
	
	signal int_readData1, int_readData2 : std_logic_vector(7 downto 0);
begin
	o_ReadData1 <= int_readData1;
	o_ReadData2 <= int_readData2;

	RS4 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RS(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RS(4),
			o_qBar => open);
	
	RS3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RS(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RS(3),
			o_qBar => open);
	
	RS2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RS(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RS(2),
			o_qBar => open);
	
	RS1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RS(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RS(1),
			o_qBar => open);
	
	RS0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RS(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RS(0),
			o_qBar => open);
	
	Inst15_15 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(15),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(15),
			o_qBar => open);

	Inst15_14 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(14),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(14),
			o_qBar => open);

	Inst15_13 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(13),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(13),
			o_qBar => open);

	Inst15_12 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(12),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(12),
			o_qBar => open);

	Inst15_11 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(11),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(11),
			o_qBar => open);

	Inst15_10 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(10),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(10),
			o_qBar => open);

	Inst15_9 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(9),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(9),
			o_qBar => open);

	Inst15_8 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(8),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(8),
			o_qBar => open);

	Inst15_7 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(7),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(7),
			o_qBar => open);

	Inst15_6 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(6),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(6),
			o_qBar => open);

	Inst15_5 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(5),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(5),
			o_qBar => open);

	Inst15_4 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(4),
			o_qBar => open);

	Inst15_3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(3),
			o_qBar => open);

	Inst15_2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(2),
			o_qBar => open);

	Inst15_1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(1),
			o_qBar => open);

	Inst15_0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => Instruction15_0(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Instruction15_0(0),
			o_qBar => open);

	RD4 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RD(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RD(4),
			o_qBar => open);

	RD3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RD(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RD(3),
			o_qBar => open);
	
	RD2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RD(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RD(2),
			o_qBar => open);
	
	RD1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RD(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RD(1),
			o_qBar => open);
	
	RD0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RD(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RD(0),
			o_qBar => open);
	
	RT4 : enARdFF_2
		port map(i_resetBar => i_reset,
		i_d => RT(4),
		i_enable => '1',
		i_clock => i_clk,
		o_q => o_RT(4),
		o_qBar => open);
	
	RT3 : enARdFF_2
		port map(i_resetBar => i_reset,
		i_d => RT(3),
		i_enable => '1',
		i_clock => i_clk,
		o_q => o_RT(3),
		o_qBar => open);
	
	RT2 : enARdFF_2
		port map(i_resetBar => i_reset,
		i_d => RT(2),
		i_enable => '1',
		i_clock => i_clk,
		o_q => o_RT(2),
		o_qBar => open);
	
	RT1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RT(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RT(1),
			o_qBar => open);
	
	RT0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => RT(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RT(0),
			o_qBar => open);
	
	Jump : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_Jump,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Jump,
			o_qBar => open);
	
	ALUSrc : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_ALUSrc,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUSrc,
			o_qBar => open);
	
	RegWrite : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_RegWrite,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RegWrite,
			o_qBar => open);
	
	MemWrite : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_MemWrite,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_MemWrite,
			o_qBar => open);
	
	MemtoReg : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_MemtoReg,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_MemtoReg,
			o_qBar => open);
	
	RegDst : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_RegDst,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RegDst,
			o_qBar => open);
	
	Branch : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_Branch,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Branch,
			o_qBar => open);
	
	MemRead : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_MemRead,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_MemRead,
			o_qBar => open);
	
	rd1_0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(0),
			o_qBar => open);
	
	rd1_1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(1),
			o_qBar => open);
			
	rd1_2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(2),
			o_qBar => open);
	
	rd1_3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(3),
			o_qBar => open);
	
	rd1_4 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(4),
			o_qBar => open);
	
	rd1_5 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(5),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(5),
			o_qBar => open);
	
	rd1_6 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(6),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(6),
			o_qBar => open);
		
	rd1_7 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData1(7),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData1(7),
			o_qBar => open);
	
	
	rd2_0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(0),
			o_qBar => open);
	
	rd2_1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(1),
			o_qBar => open);
			
	rd2_2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(2),
			o_qBar => open);
	
	rd2_3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(3),
			o_qBar => open);
	
	rd2_4 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(4),
			o_qBar => open);
	
	rd2_5 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(5),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(5),
			o_qBar => open);
	
	rd2_6 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(6),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(6),
			o_qBar => open);
		
	rd2_7 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ReadData2(7),
			i_enable => '1',
			i_clock => i_clk,
			o_q => int_readData2(7),
			o_qBar => open);
end rtl;