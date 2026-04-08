library ieee;
use ieee.std_logic_1164.all;

entity EXMEM_Pipe is
	port(ALUResult, i_readData2 : in std_logic_vector(7 downto 0);
		i_rt : in std_logic_vector(4 downto 0); --, i_rd
		i_Branch, i_MemRead, i_MemWrite, i_MemtoReg, i_RegWrite, i_reset, i_clk : in std_logic;
		o_ALUResult, o_readData2 : out std_logic_vector(7 downto 0);
		o_rt : out std_logic_vector(4 downto 0); --, o_rd
		o_Branch, o_MemRead, o_MemWrite, o_MemtoReg, o_RegWrite : out std_logic);
end entity;

architecture rtl of EXMEM_Pipe is
	component enARdFF_2
		port(i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	end component;
begin
--	rd4 : enARdFF_2
--		port map(i_resetBar => i_reset,
--			i_d => i_rd(4),
--			i_enable => '1',
--			i_clock => i_clk,
--			o_q => o_rd(4),
--			o_qBar => open);
--
--	rd3 : enARdFF_2
--		port map(i_resetBar => i_reset,
--			i_d => i_rd(3),
--			i_enable => '1',
--			i_clock => i_clk,
--			o_q => o_rd(3),
--			o_qBar => open);
--
--	rd2 : enARdFF_2
--		port map(i_resetBar => i_reset,
--			i_d => i_rd(2),
--			i_enable => '1',
--			i_clock => i_clk,
--			o_q => o_rd(2),
--			o_qBar => open);
--
--	rd1 : enARdFF_2
--		port map(i_resetBar => i_reset,
--			i_d => i_rd(1),
--			i_enable => '1',
--			i_clock => i_clk,
--			o_q => o_rd(1),
--			o_qBar => open);
--
--	rd0 : enARdFF_2
--		port map(i_resetBar => i_reset,
--			i_d => i_rd(0),
--			i_enable => '1',
--			i_clock => i_clk,
--			o_q => o_rd(0),
--			o_qBar => open);

	readData2_7 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(7),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(7),
			o_qBar => open);

	readData2_6 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(6),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(6),
			o_qBar => open);

	readData2_5 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(5),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(5),
			o_qBar => open);

	readData2_4	: enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(4),
			o_qBar => open);

	readData2_3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(3),
			o_qBar => open);

	readData2_2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(2),
			o_qBar => open);

	readData2_1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(1),
			o_qBar => open);

	readData2_0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_readData2(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_readData2(0),
			o_qBar => open);

	rt4 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_rt(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_rt(4),
			o_qBar => open);

	rt3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_rt(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_rt(3),
			o_qBar => open);

	rt2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_rt(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_rt(2),
			o_qBar => open);

	rt1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_rt(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_rt(1),
			o_qBar => open);

	rt0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_rt(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_rt(0),
			o_qBar => open);

	ALURes7 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(7),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(7),
			o_qBar => open);

	ALURes6 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(6),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(6),
			o_qBar => open);

	ALURes5 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(5),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(5),
			o_qBar => open);

	ALURes4 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(4),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(4),
			o_qBar => open);

	ALURes3 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(3),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(3),
			o_qBar => open);

	ALURes2 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(2),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(2),
			o_qBar => open);

	ALURes1 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(1),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(1),
			o_qBar => open);

	ALURes0 : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => ALUResult(0),
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_ALUResult(0),
			o_qBar => open);

	branchDFF : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_Branch,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_Branch,
			o_qBar => open);
			
	memReadDFF : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_MemRead,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_MemRead,
			o_qBar => open);
	
	memWriteDFF : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_MemWrite,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_MemWrite,
			o_qBar => open);
	
	memToRegDFF : enARdFF_2
		port map(i_resetBar => i_reset,
		i_d => i_MemtoReg,
		i_enable => '1',
		i_clock => i_clk,
		o_q => o_MemtoReg,
		o_qBar => open);
	
	regWriteDFF : enARdFF_2
		port map(i_resetBar => i_reset,
			i_d => i_RegWrite,
			i_enable => '1',
			i_clock => i_clk,
			o_q => o_RegWrite,
			o_qBar => open);
	
end rtl;