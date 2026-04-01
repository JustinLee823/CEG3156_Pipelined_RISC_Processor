library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
	port(Inst : in std_logic_vector(5 downto 0);
		RegDst, Branch, MemRead, MemtoReg, MemWrite, RegWrite, ALUSrc, Jump : out std_logic;
		ALUOp : out std_logic_vector(1 downto 0));
end entity;

architecture rtl of ControlUnit is

begin

	RegDst <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and not(Inst(1)) and not(Inst(0));
	Branch <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and Inst(2) and not(Inst(1)) and not(Inst(0));
	Jump <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and not(Inst(0));
	MemRead <= Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0);
	MemtoReg <= Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0);
	MemWrite <= Inst(5) and not(Inst(4)) and Inst(3) and not(Inst(2)) and Inst(1) and Inst(0);
	RegWrite <= (Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0)) or (not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and not(Inst(1)) and not(Inst(0)));
	ALUSrc <= (Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0)) or (Inst(5) and not(Inst(4)) and Inst(3) and not(Inst(2)) and Inst(1) and Inst(0));
	ALUOp(1) <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and not(Inst(1)) and not(Inst(0));
	ALUOp(0) <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and Inst(2) and not(Inst(1)) and not(Inst(0));
end rtl; 