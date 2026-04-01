Library IEEE;
use ieee.std_logic_1164.all;

Entity ALU8bit is
	port(
	A,B: in std_logic_vector(7 downto 0);
	opSel: in std_logic_vector(2 downto 0);
	zero : out std_logic;
	AluOut: out std_logic_vector(7 downto 0)	
	);
end Entity;
	
Architecture rtl of ALU8bit is

component eightBitAdder
	port(i_a, i_b : in std_logic_vector(7 downto 0);
		i_cin : in std_logic;
		zero : out std_logic;
		o_cout : out std_logic;
		o_Value : out std_logic_vector(7 downto 0));
end component;

component mux8to1_8bit
	port(
	i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7: in std_logic_vector(7 downto 0);
	i_sel: in std_logic_vector(2 downto 0);
	o_y: out std_logic_vector(7 downto 0)
	);
end component;

signal i_bAdder: std_logic_vector(7 downto 0); -- Input to Adder. Inverted when opSel(2) == 1
signal i_AND,i_OR: std_logic_vector(7 downto 0);
signal o_Adder, o_mux: std_logic_vector(7 downto 0);
signal int_zero : std_logic;

begin

i_bAdder <= B XOR (7 downto 0 => opSel(2));
i_AND <= A AND B;
i_OR <= A OR B;



adder1: eightBitAdder
	port map(
	i_a => A,
	i_b => i_bAdder,
	i_cin => opSel(2),
	zero => int_zero,
	o_cout => open,
	o_Value => o_Adder
	);
	
mux1: mux8to1_8bit
	port map(
	i_0 => i_AND,
	i_1 => i_OR,
	i_2 => o_Adder,
	i_3 => "00000000",
	i_4 => "00000000",
	i_5 => "00000000",
	i_6 => o_Adder,
	i_7 => "00000000",
	i_sel => opSel,
	o_y => o_mux
	);
	
AluOut <= o_mux;
zero <= int_zero;

end Architecture rtl;

