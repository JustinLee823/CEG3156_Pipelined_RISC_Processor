Library IEEE;
use ieee.std_logic_1164.all;

Entity mux8to1_1bit is
	port(
	i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7: in std_logic;
	i_sel: in std_logic_vector(2 downto 0);
	o_y: out std_logic
	);
End entity;

Architecture rtl of mux8to1_1bit is
begin

o_y <= (i_0 AND NOT i_sel(2) AND NOT i_sel(1) AND NOT i_sel(0)) OR
           (i_1 AND NOT i_sel(2) AND NOT i_sel(1) AND     i_sel(0)) OR
           (i_2 AND NOT i_sel(2) AND     i_sel(1) AND NOT i_sel(0)) OR
           (i_3 AND NOT i_sel(2) AND     i_sel(1) AND     i_sel(0)) OR
           (i_4 AND     i_sel(2) AND NOT i_sel(1) AND NOT i_sel(0)) OR
           (i_5 AND     i_sel(2) AND NOT i_sel(1) AND     i_sel(0)) OR
           (i_6 AND     i_sel(2) AND     i_sel(1) AND NOT i_sel(0)) OR
           (i_7 AND     i_sel(2) AND     i_sel(1) AND     i_sel(0));
			  
end architecture rtl;