library ieee;
use ieee.std_logic_1164.all;

entity ALUControl is
	port(ALUOp : in std_logic_vector(1 downto 0);
		Funct : in std_logic_vector(5 downto 0);
		Operation : out std_logic_vector(2 downto 0));
end entity;

architecture rtl of ALUControl is

begin
	Operation(0) <= (ALUOp(1) and Funct(2) and Funct(0));
	Operation(1) <=((not(ALUOp(1))and not(ALUOp(0))) or (((ALUOp(1)) or (ALUOp(0)))and (not(Funct(3)) and not(Funct(2)) and not(Funct(0)))));
	Operation(2) <= (ALUOp(0) or (ALUOp(1) and Funct(1) and not(ALUOp(0)))); 
end rtl;