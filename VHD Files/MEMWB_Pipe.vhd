library ieee;
use ieee.std_logic_1164.all;

entity MEMWB_Pipe is
	port(i_MemtoReg, i_RegWrite : in std_logic;
		o_MemtoReg, o_RegWrite : out std_logic);
end entity;

architecture rtl of MEMWB_Pipe is

begin 

end rtl;