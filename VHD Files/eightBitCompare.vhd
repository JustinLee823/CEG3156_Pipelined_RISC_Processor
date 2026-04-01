library ieee;
use ieee.std_logic_1164.all;

entity eightBitCompare is 
	port(i_Ai, i_Bi : in std_logic_vector(7 downto 0);
		equal : out std_logic);
end entity;

architecture rtl of eightBitCompare is
	component oneBitComparator
		port(i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
		i_Ai, i_Bi			: IN	STD_LOGIC;
		o_GT, o_LT			: OUT	STD_LOGIC);
	end component;
	
	signal int_GT, int_LT : std_logic_vector(7 downto 0);
	signal gnd : std_logic;
begin
	gnd <= '0';
	
	comp7 : oneBitComparator
		port map(i_GTPrevious => gnd,
			i_LTPrevious => gnd,
			i_Ai => i_Ai(7),
			i_Bi => i_Bi(7),
			o_GT => int_GT(7),
			o_LT => int_LT(7));
	
	comp6 : oneBitComparator
		port map(i_GTPrevious => int_GT(7),
			i_LTPrevious => int_LT(7),
			i_Ai => i_Ai(6),
			i_Bi => i_Bi(6),
			o_GT => int_GT(6),
			o_LT => int_LT(6));
			
	comp5 : oneBitComparator
		port map(i_GTPrevious => int_GT(6),
			i_LTPrevious => int_LT(6),
			i_Ai => i_Ai(5),
			i_Bi => i_Bi(5),
			o_GT => int_GT(5),
			o_LT => int_LT(5));
	
	comp4 : oneBitComparator
		port map(i_GTPrevious => int_GT(5),
			i_LTPrevious => int_LT(5),
			i_Ai => i_Ai(4),
			i_Bi => i_Bi(4),
			o_GT => int_GT(4),
			o_LT => int_LT(4));
	
	comp3 : oneBitComparator
		port map(i_GTPrevious => int_GT(4),
			i_LTPrevious => int_LT(4),
			i_Ai => i_Ai(3),
			i_Bi => i_Bi(3),
			o_GT => int_GT(3),
			o_LT => int_LT(3));
	
	comp2 : oneBitComparator
		port map(i_GTPrevious => int_GT(3),
			i_LTPrevious => int_LT(3),
			i_Ai => i_Ai(2),
			i_Bi => i_Bi(2),
			o_GT => int_GT(2),
			o_LT => int_LT(2));
	
	comp1 : oneBitComparator
		port map(i_GTPrevious => int_GT(2),
			i_LTPrevious => int_LT(2),
			i_Ai => i_Ai(1),
			i_Bi => i_Bi(1),
			o_GT => int_GT(1),
			o_LT => int_LT(1));
	
	comp0 : oneBitComparator
		port map(i_GTPrevious => int_GT(1),
			i_LTPrevious => int_LT(1),
			i_Ai => i_Ai(0),
			i_Bi => i_Bi(0),
			o_GT => int_GT(0),
			o_LT => int_LT(0));

	equal <= int_GT(0) nor int_LT(0);
end rtl;