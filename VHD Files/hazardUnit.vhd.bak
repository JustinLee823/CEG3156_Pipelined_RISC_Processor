library ieee;
use ieee.std_logic_1164.all;

entity hazardUnit is
    port(
        memRead     : in std_logic;
        IDEX_rt     : in std_logic_vector(4 downto 0);
        IFID_rs     : in std_logic_vector(4 downto 0);
        IFID_rt     : in std_logic_vector(4 downto 0);
        stall       : out std_logic
    );
end hazardUnit;

architecture structural of hazardUnit is
    signal rt_equals_rs, rt_equals_rt   : std_logic;

    begin
    rt_equals_rs <= (IDEX_rt(4) XNOR IFID_rs(4)) AND (IDEX_rt(3) XNOR IFID_rs(3)) AND 
                    (IDEX_rt(2) XNOR IFID_rs(2)) AND (IDEX_rt(1) XNOR IFID_rs(1)) AND (IDEX_rt(0) XNOR IFID_rs(0));

    rt_equals_rt <= (IDEX_rt(4) XNOR IFID_rt(4)) AND (IDEX_rt(3) XNOR IFID_rt(3)) AND 
                    (IDEX_rt(2) XNOR IFID_rt(2)) AND (IDEX_rt(1) XNOR IFID_rt(1)) AND (IDEX_rt(0) XNOR IFID_rt(0));         

    stall <= memRead AND (rt_equals_rs or rt_equals_rt);

end structural;