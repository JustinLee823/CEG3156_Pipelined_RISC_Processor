library ieee;
use ieee.std_logic_1164.all;

entity IFID_Pipe is
	port(i_Flush, i_stall, i_enable, i_clk, GReset : in std_logic;
		PCplus4 : in std_logic_vector(7 downto 0);
		Instruction : in std_logic_vector(31 downto 0);
		o_PC : out std_logic_vector(7 downto 0);
		o_Instruction : out std_logic_vector(31 downto 0));
end entity;

architecture rtl of IFID_Pipe is
	component enARdFF_2
		port(i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	end component;
	
	
	signal int_Inst : std_logic_vector(31 downto 0);
	signal int_PC : std_logic_vector(7 downto 0);
begin
	PC0 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(0),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(0),
			o_qBar => open);
	
	PC1 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(1),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(1),
			o_qBar => open);
	
	PC2 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(2),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(2),
			o_qBar => open);
	
	PC3 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(3),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(3),
			o_qBar => open);
	
	PC4 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(4),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(4),
			o_qBar => open);
			
	PC5 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(5),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(5),
			o_qBar => open);
			
	PC6 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(6),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(6),
			o_qBar => open);
			
	PC7 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => PCplus4(7),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_PC(7),
			o_qBar => open);
	
	dFF0 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(0),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(0),
			o_qBar => open);
	dFF1 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(1),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(1),
			o_qBar => open);
	dFF2 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(2),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(2),
			o_qBar => open);
	dFF3 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(3),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(3),
			o_qBar => open);
	dFF4 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(4),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(4),
			o_qBar => open);
	dFF5 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(5),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(5),
			o_qBar => open);
	dFF6 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(6),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(6),
			o_qBar => open);
	dFF7 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(7),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(7),
			o_qBar => open);
	dFF8 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(8),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(8),
			o_qBar => open);
	dFF9 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(9),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(9),
			o_qBar => open);
	dFF10 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(10),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(10),
			o_qBar => open);
	dFF11 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(11),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(11),
			o_qBar => open);
	dFF12 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(12),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(12),
			o_qBar => open);
	dFF13 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(13),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(13),
			o_qBar => open);
	dFF14 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(14),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(14),
			o_qBar => open);
	dFF15 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(15),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(15),
			o_qBar => open);
	dFF16 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(16),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(16),
			o_qBar => open);
	dFF17 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(17),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(17),
			o_qBar => open);
	dFF18 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(18),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(18),
			o_qBar => open);
	dFF19 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(19),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(19),
			o_qBar => open);
	dFF20 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(20),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(20),
			o_qBar => open);
	dFF21 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(21),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(21),
			o_qBar => open);
	dFF22 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(22),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(22),
			o_qBar => open);
	dFF23 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(23),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(23),
			o_qBar => open);
	dFF24 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(24),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(24),
			o_qBar => open);
	dFF25 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(25),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(25),
			o_qBar => open);
	dFF26 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(26),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(26),
			o_qBar => open);
	dFF27 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(27),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(27),
			o_qBar => open);
	dFF28 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(28),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(28),
			o_qBar => open);
	dFF29 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(29),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(29),
			o_qBar => open);
	dFF30 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(30),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(30),
			o_qBar => open);
	dFF31 : enARdFF_2
		port map(i_resetBar => i_Flush or GReset,
			i_d => Instruction(31),
			i_enable => i_enable and not(i_stall),
			i_clock => i_clk,
			o_q => int_Inst(31),
			o_qBar => open);
	
	o_PC <= int_PC;
	o_Instruction <= int_Inst;
end rtl;