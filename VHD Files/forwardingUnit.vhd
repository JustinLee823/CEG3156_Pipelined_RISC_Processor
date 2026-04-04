library ieee;
use ieee.std_logic_1164.all;

entity forwardingUnit is
    port(
        EXMEM_RegWrite      : in std_logic;
        EXMEM_RegisterRd    : in std_logic_vector(7 downto 0);
        IDEX_RegisterRs     : in std_logic_vector(7 downto 0);
        IDEX_RegisterRt     : in std_logic_vector(7 downto 0);

        MEMWB_RegWrite      : in std_logic;
        MEMWB_RegisterRd    : in std_logic_vector(7 downto 0);

        ForwardA    : out std_logic_vector(1 downto 0);
        ForwardB    : out std_logic_vector(1 downto 0)
    );
end forwardingUnit;

architecture structural of forwardingUnit is
    signal EXMEM_RegisterRd_equals_rs   : std_logic;        -- All rs refer to ID/EX.RegisterRs
    signal EXMEM_RegisterRd_equals_rt   : std_logic;        -- All rt refer to ID/EX.RegisterRt
    signal MEMWB_RegisterRd_equals_rs   : std_logic;
    signal MEMWB_RegisterRd_equals_rt   : std_logic;

    signal zero_register                   : std_logic_vector(7 downto 0);
    signal EXMEM_RegisterRd_equals_zeroReg : std_logic;                        
    signal MEMWB_RegisterRd_equals_zeroReg : std_logic;

    signal type1, type2, type3, type4   : std_logic;
    -- Type 1 --> ForwardA = 10
    -- Type 2 --> ForwardB = 10
    -- Type 3 --> ForwardA = 01
    -- Type 4 --> ForwardB = 01

    begin
    zero_register <= "00000000";

    EXMEM_RegisterRd_equals_rs <= (EXMEM_RegisterRd(7) XNOR IDEX_RegisterRs(7)) AND (EXMEM_RegisterRd(6) XNOR IDEX_RegisterRs(6)) AND 
                                  (EXMEM_RegisterRd(5) XNOR IDEX_RegisterRs(5)) AND (EXMEM_RegisterRd(4) XNOR IDEX_RegisterRs(4)) AND 
                                  (EXMEM_RegisterRd(3) XNOR IDEX_RegisterRs(3)) AND (EXMEM_RegisterRd(2) XNOR IDEX_RegisterRs(2)) AND
                                  (EXMEM_RegisterRd(1) XNOR IDEX_RegisterRs(1)) AND (EXMEM_RegisterRd(0) XNOR IDEX_RegisterRs(0));
    
    EXMEM_RegisterRd_equals_rt <= (EXMEM_RegisterRd(7) XNOR IDEX_RegisterRt(7)) AND (EXMEM_RegisterRd(6) XNOR IDEX_RegisterRt(6)) AND
                                  (EXMEM_RegisterRd(5) XNOR IDEX_RegisterRt(5)) AND (EXMEM_RegisterRd(4) XNOR IDEX_RegisterRt(4)) AND 
                                  (EXMEM_RegisterRd(3) XNOR IDEX_RegisterRt(3)) AND (EXMEM_RegisterRd(2) XNOR IDEX_RegisterRt(2)) AND
                                  (EXMEM_RegisterRd(1) XNOR IDEX_RegisterRt(1)) AND (EXMEM_RegisterRd(0) XNOR IDEX_RegisterRt(0));
                               
    MEMWB_RegisterRd_equals_rs <= (MEMWB_RegisterRd(7) XNOR IDEX_RegisterRs(7)) AND (MEMWB_RegisterRd(6) XNOR IDEX_RegisterRs(6)) AND
                                  (MEMWB_RegisterRd(5) XNOR IDEX_RegisterRs(5)) AND (MEMWB_RegisterRd(4) XNOR IDEX_RegisterRs(4)) AND                             
                                  (MEMWB_RegisterRd(3) XNOR IDEX_RegisterRs(3)) AND (MEMWB_RegisterRd(2) XNOR IDEX_RegisterRs(2)) AND
                                  (MEMWB_RegisterRd(1) XNOR IDEX_RegisterRs(1)) AND (MEMWB_RegisterRd(0) XNOR IDEX_RegisterRs(0));
    
    MEMWB_RegisterRd_equals_rt <= (MEMWB_RegisterRd(7) XNOR IDEX_RegisterRt(7)) AND (MEMWB_RegisterRd(6) XNOR IDEX_RegisterRt(6)) AND
                                  (MEMWB_RegisterRd(5) XNOR IDEX_RegisterRt(5)) AND (MEMWB_RegisterRd(4) XNOR IDEX_RegisterRt(4)) AND
                                  (MEMWB_RegisterRd(3) XNOR IDEX_RegisterRt(3)) AND (MEMWB_RegisterRd(2) XNOR IDEX_RegisterRt(2)) AND
                                  (MEMWB_RegisterRd(1) XNOR IDEX_RegisterRt(1)) AND (MEMWB_RegisterRd(0) XNOR IDEX_RegisterRt(0));                  
    
    EXMEM_RegisterRd_equals_zeroReg <=  (EXMEM_RegisterRd(7) XNOR zero_register(7)) AND (EXMEM_RegisterRd(6) XNOR zero_register(6)) AND
                                        (EXMEM_RegisterRd(5) XNOR zero_register(5)) AND (EXMEM_RegisterRd(4) XNOR zero_register(4)) AND
                                        (EXMEM_RegisterRd(3) XNOR zero_register(3)) AND (EXMEM_RegisterRd(2) XNOR zero_register(2)) AND 
                                        (EXMEM_RegisterRd(1) XNOR zero_register(1)) AND (EXMEM_RegisterRd(0) XNOR zero_register(0));

    MEMWB_RegisterRd_equals_zeroReg <=  (MEMWB_RegisterRd(7) XNOR zero_register(7)) AND (MEMWB_RegisterRd(6) XNOR zero_register(6)) AND
                                        (MEMWB_RegisterRd(5) XNOR zero_register(5)) AND (MEMWB_RegisterRd(4) XNOR zero_register(4)) AND
                                        (MEMWB_RegisterRd(3) XNOR zero_register(3)) AND (MEMWB_RegisterRd(2) XNOR zero_register(2)) AND
                                        (MEMWB_RegisterRd(1) XNOR zero_register(1)) AND (MEMWB_RegisterRd(0) XNOR zero_register(0));

    type1 <= EXMEM_RegWrite AND NOT(EXMEM_RegisterRd_equals_zeroReg) AND EXMEM_RegisterRd_equals_rs;
    type2 <= EXMEM_RegWrite AND NOT(EXMEM_RegisterRd_equals_zeroReg) AND EXMEM_RegisterRd_equals_rt;
    type3 <= MEMWB_RegWrite AND NOT(MEMWB_RegisterRd_equals_zeroReg) AND MEMWB_RegisterRd_equals_rs;
    type4 <= MEMWB_RegWrite AND NOT(MEMWB_RegisterRd_equals_zeroReg) AND MEMWB_RegisterRd_equals_rt;

    -- FowardA MUX
    ForwardA(1) <= type1;
    ForwardA(0) <= NOT(type1) AND type3;

    -- ForwardB MUX
    ForwardB(1) <= type2;
    ForwardB(0) <= NOT(type2) AND type4;

end structural;