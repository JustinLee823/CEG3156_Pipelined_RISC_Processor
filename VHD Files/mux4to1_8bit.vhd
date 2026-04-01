Library IEEE;
use ieee.std_logic_1164.all;

Entity mux4to1_8bit is
	port(
	i_0,i_1,i_2,i_3: in std_logic_vector(7 downto 0);
	i_sel: in std_logic_vector(1 downto 0);
	o_y: out std_logic_vector(7 downto 0)
	);
End entity;

Architecture rtl of mux4to1_8bit is

component mux4to1_1bit
port(
	i_0,i_1,i_2,i_3: in std_logic;
	i_sel: in std_logic_vector(1 downto 0);
	o_y: out std_logic
	);
end component;

begin

mux1: mux4to1_1bit
	port map(
		i_0 => i_0(0),
		i_1 => i_1(0),
		i_2 => i_2(0),
		i_3 => i_3(0),
		i_sel => i_sel,
		o_y => o_y(0)
	);
	
mux2: mux4to1_1bit
	port map(
		i_0 => i_0(1),
		i_1 => i_1(1),
		i_2 => i_2(1),
		i_3 => i_3(1),
		i_sel => i_sel,
		o_y => o_y(1)
	);

mux3: mux4to1_1bit
	port map(
		i_0 => i_0(2),
		i_1 => i_1(2),
		i_2 => i_2(2),
		i_3 => i_3(2),
		i_sel => i_sel,
		o_y => o_y(2)
	);
	
mux4: mux4to1_1bit
	port map(
		i_0 => i_0(3),
		i_1 => i_1(3),
		i_2 => i_2(3),
		i_3 => i_3(3),
		i_sel => i_sel,
		o_y => o_y(3)
	);

mux5: mux4to1_1bit
	port map(
		i_0 => i_0(4),
		i_1 => i_1(4),
		i_2 => i_2(4),
		i_3 => i_3(4),
		i_sel => i_sel,
		o_y => o_y(4)
	);

mux6: mux4to1_1bit
	port map(
		i_0 => i_0(5),
		i_1 => i_1(5),
		i_2 => i_2(5),
		i_3 => i_3(5),
		i_sel => i_sel,
		o_y => o_y(5)
	);

mux7: mux4to1_1bit
	port map(
		i_0 => i_0(6),
		i_1 => i_1(6),
		i_2 => i_2(6),
		i_3 => i_3(6),
		i_sel => i_sel,
		o_y => o_y(6)
	);
	
mux8: mux4to1_1bit
	port map(
		i_0 => i_0(7),
		i_1 => i_1(7),
		i_2 => i_2(7),
		i_3 => i_3(7),
		i_sel => i_sel,
		o_y => o_y(7)
	);
end Architecture rtl;