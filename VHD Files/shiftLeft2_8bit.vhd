library ieee;
use ieee.std_logic_1164.all;

entity shiftLeft2_8bit is
	port(i_value : in std_logic_vector(7 downto 0);
		o_value : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of shiftLeft2_8bit is

	signal int_val : std_logic_vector(7 downto 0);

begin
	
	int_val(0) <= '0';
	int_val(1) <= '0';
	int_val(2) <= i_value(0);
	int_val(3) <= i_value(1);
	int_val(4) <= i_value(2);
	int_val(5) <= i_value(3);
	int_val(6) <= i_value(4);
	int_val(7) <= i_value(5);
	
	o_value <= int_val;
end rtl;