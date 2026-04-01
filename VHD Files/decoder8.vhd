library ieee;
use ieee.std_logic_1164.all;

entity decoder8 is
	port(i_value : in std_logic_vector(2 downto 0);
		enable : in std_logic;
		o_value : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of decoder8 is
begin 
	o_value(7) <= i_value(2) and i_value(1) and i_value(0) and enable; 
	o_value(6) <= i_value(2) and i_value(1) and not i_value(0) and enable; 
	o_value(5) <= i_value(2) and not i_value(1) and i_value(0) and enable;	
	o_value(4) <= i_value(2) and not i_value(1) and not i_value(0) and enable;
	o_value(3) <= not i_value(2) and i_value(1) and i_value(0) and enable;
	o_value(2) <= not i_value(2) and i_value(1) and not i_value(0) and enable;
	o_value(1) <= not i_value(2) and not i_value(1) and i_value(0) and enable;
	o_value(0) <= not i_value(2) and not i_value(1) and not i_value(0) and enable;
end rtl;