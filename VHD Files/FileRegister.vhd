library ieee;
use ieee.std_logic_1164.all;

entity FileRegister is
	port(RegWrite, GReset, GClock : in std_logic;
		readReg1, readReg2, writeReg : in std_logic_vector(2 downto 0);
		writeData : in std_logic_vector(7 downto 0);
		readData1, readData2 : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of FileRegister is

	component decoder8
		port(i_value : in std_logic_vector(2 downto 0);
			enable : in std_logic;
			o_value : out std_logic_vector(7 downto 0));
	end component;
	
	component mux8to1_8bit
		port(i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7: in std_logic_vector(7 downto 0);
			i_sel: in std_logic_vector(2 downto 0);
			o_y: out std_logic_vector(7 downto 0));
	end component;
	
	component eightBitRegister
		port(i_resetBar, i_load : IN STD_LOGIC;
        i_clock            : IN STD_LOGIC;
        i_Value            : IN STD_LOGIC_VECTOR(7 downto 0);
        o_Value            : OUT STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	signal int_RegDest : std_logic_vector(7 downto 0);
	signal muxInput0, muxInput1, muxInput2, muxInput3, muxInput4, muxInput5, muxInput6, muxInput7 : std_logic_vector(7 downto 0);
	signal muxOut1, muxOut2 : std_logic_vector(7 downto 0);
begin
	WriteRegDest : decoder8
		port map(i_value => writeReg,
			enable => RegWrite,
			o_value => int_RegDest);
	
	Reg7 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(7),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput7);
	
	Reg6 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(6),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput6);
		
	Reg5 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(5),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput5);
		
	Reg4 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(4),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput4);
		
	Reg3 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(3),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput3);
	
	Reg2 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(2),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput2);
	
	Reg1 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(1),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput1);
	
	Reg0 : eightBitRegister
		port map(i_resetBar => GReset,
			i_load => int_RegDest(0),
			i_clock => GClock,
			i_Value => writeData,
			o_Value => muxInput0);
	
	mux1 : mux8to1_8bit
		port map(i_0 => muxInput0,
			i_1 => muxInput1,
			i_2 => muxInput2,
			i_3 => muxInput3,
			i_4 => muxInput4,
			i_5 => muxInput5,
			i_6 => muxInput6,
			i_7 => muxInput7,
			i_sel => readReg1,
			o_y => muxOut1);
	
	mux2 : mux8to1_8bit
		port map(i_0 => muxInput0,
			i_1 => muxInput1,
			i_2 => muxInput2,
			i_3 => muxInput3,
			i_4 => muxInput4,
			i_5 => muxInput5,
			i_6 => muxInput6,
			i_7 => muxInput7,
			i_sel => readReg2,
			o_y => muxOut2);
	
	readData1 <= muxOut1;
	readData2 <= muxOut2;
end rtl;