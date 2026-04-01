library ieee;
use ieee.std_logic_1164.all;

entity IDEX_Pipe is
	port(ReadData1, ReadData2 : in std_logic_vector(7 downto 0);
		i_RegDst, i_Branch, i_MemRead, i_MemtoReg, i_MemWrite, i_RegWrite, i_ALUSrc, i_Jump : in std_logic;
		o_RegDst, o_Branch, o_MemRead, o_MemtoReg, o_MemWrite, o_RegWrite, o_ALUSrc, o_Jump : out std_logic);
end entity;

architecture rtl of IDEX_Pipe is

begin
	
end rtl;