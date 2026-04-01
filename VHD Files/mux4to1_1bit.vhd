Library IEEE;
use ieee.std_logic_1164.all;

Entity mux4to1_1bit is
	port(
	i_0,i_1,i_2,i_3: in std_logic;
	i_sel: in std_logic_vector(1 downto 0);
	o_y: out std_logic
	);
End entity;

Architecture rtl of mux4to1_1bit is
begin

o_y <= (i_0  AND NOT i_sel(1) AND NOT i_sel(0)) OR
           (i_1 AND NOT i_sel(1) AND     i_sel(0)) OR
           (i_2 AND     i_sel(1) AND NOT i_sel(0)) OR
           (i_3 AND     i_sel(1) AND     i_sel(0));
			  
end architecture rtl;