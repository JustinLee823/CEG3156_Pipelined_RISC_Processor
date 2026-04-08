library ieee;
use ieee.std_logic_1164.all;

entity MEMWB_Pipe is
	port(i_MemtoReg, i_RegWrite, GReset, Gclock : in std_logic;
		i_RTRD : in std_logic_vector(4 downto 0);
		i_dataMem, i_ALUresult : in std_logic_vector(7 downto 0);
		MEMWB_RTRD : out std_logic_vector(4 downto 0);
		MEMWB_dataMemOut, MEMWB_ALUresult : out std_logic_vector(7 downto 0);
		MEMWB_MemtoReg, MEMWB_RegWrite : out std_logic);
end entity;

architecture rtl of MEMWB_Pipe is

component enARdFF_2
PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
end component;

begin
	rtrd4 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_RTRD(4),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_RTRD(4),
			o_qBar => open);

	rtrd3 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_RTRD(3),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_RTRD(3),
			o_qBar => open);

	rtrd2 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_RTRD(2),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_RTRD(2),
			o_qBar => open);

	rtrd1 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_RTRD(1),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_RTRD(1),
			o_qBar => open);

	rtrd0 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_RTRD(0),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_RTRD(0),
			o_qBar => open);

	aluresult7 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(7),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(7),
			o_qBar => open);

	aluresult6 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(6),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(6),
			o_qBar => open);

	aluresult5 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(5),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(5),
			o_qBar => open);

	aluresult4 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(4),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(4),
			o_qBar => open);

	aluresult3 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(3),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(3),
			o_qBar => open);

	aluresult2 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(2),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(2),
			o_qBar => open);

	aluresult1 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(1),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(1),
			o_qBar => open);

	aluresult0 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_ALUresult(0),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_ALUresult(0),
			o_qBar => open);

	DataMem7 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(7),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(7),
			o_qBar => open);

	DataMem6 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(6),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(6),
			o_qBar => open);

	DataMem5 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(5),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(5),
			o_qBar => open);

	DataMem4 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(4),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(4),
			o_qBar => open);

	DataMem3 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(3),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(3),
			o_qBar => open);

	DataMem2 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(2),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(2),
			o_qBar => open);

	DataMem1 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(1),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(1),
			o_qBar => open);

	DataMem0 : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_dataMem(0),
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_dataMemOut(0),
			o_qBar => open);

	memtoreg : enARdFF_2
		port map(i_resetBar => GReset,
			i_d => i_MemtoReg,
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_MemtoReg,
			o_qBar => open);
			
	regwrite : enARdFF_2
		port map(i_resetBar => Greset,
			i_d => i_RegWrite,
			i_enable => '1',
			i_clock => Gclock,
			o_q => MEMWB_RegWrite,
			o_qBar => open);

end rtl;
