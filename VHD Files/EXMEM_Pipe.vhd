library ieee;
use ieee.std_logic_1164.all;

entity EXMEM_Pipe is
	port(i_Branch, i_MemRead, i_MemWrite, i_MemtoReg, i_RegWrite : in std_logic;
		o_Branch, o_MemRead, o_MemWrite, o_MemtoReg, o_RegWrite : out std_logic);
end entity;

architecture rtl of EXMEM_Pipe is

begin

end rtl;