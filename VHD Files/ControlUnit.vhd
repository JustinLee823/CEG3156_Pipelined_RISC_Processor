library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
	port(Inst : in std_logic_vector(5 downto 0);
		Zero : in std_logic;
		controlOut : out std_logic_vector(10 downto 0));
end entity;

architecture rtl of ControlUnit is
	signal RegDst, Branch, MemRead, MemtoReg, MemWrite, RegWrite, ALUSrc, Jump, IF_Flush : std_logic;
	signal ALUOp : std_logic_vector(1 downto 0);

begin
	--Execution/Address calculation
	RegDst <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and not(Inst(1)) and not(Inst(0));
	ALUOp(1) <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and not(Inst(1)) and not(Inst(0));
	ALUOp(0) <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and Inst(2) and not(Inst(1)) and not(Inst(0));
	ALUSrc <= (Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0)) or (Inst(5) and not(Inst(4)) and Inst(3) and not(Inst(2)) and Inst(1) and Inst(0));
	
	--Memory access stage
	Branch <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and Inst(2) and not(Inst(1)) and not(Inst(0));
	MemRead <= Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0);
	MemWrite <= Inst(5) and not(Inst(4)) and Inst(3) and not(Inst(2)) and Inst(1) and Inst(0);
	
	--stage control
	MemtoReg <= Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0);
	RegWrite <= (Inst(5) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and Inst(0)) or (not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and not(Inst(1)) and not(Inst(0)));
	
	--Other control signals
	IF_Flush <= ((not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and Inst(2) and not(Inst(1)) and not(Inst(0))) and Zero) or (not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and not(Inst(0)));
	Jump <= not(Inst(5)) and not(Inst(4)) and not(Inst(3)) and not(Inst(2)) and Inst(1) and not(Inst(0));
	
	controlOut(0) <= RegDst;
	controlOut(1) <= ALUOp(0);
	controlOut(2) <= ALUOp(1);
	controlOut(3) <= ALUSrc;
	controlOut(4) <= Branch;
	controlOut(5) <= MemRead;
	controlOut(6) <= MemWrite;
	controlOut(7) <= MemtoReg;
	controlOut(8) <= RegWrite;
	controlOut(9) <= IF_Flush;
	controlOut(10) <= Jump;
end rtl; 