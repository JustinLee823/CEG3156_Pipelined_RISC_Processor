library ieee;
use ieee.std_logic_1164.all;

entity Datapath is
	port(
		Greset, Gclock : in std_logic;
		ValueSelect : in std_logic_vector(2 downto 0);
		Zero, MemWriteOut, RegWriteOut, BranchOut, RegisterDst, MemoryToRegister, MemoryRead, JumpOut, ALUSRC : out std_logic;
		ALUop1, ALUop2 : out std_logic;
		InstructionOut : out std_logic_vector(31 downto 0);
		MuxOut : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of Datapath is

	component ALU8bit
		port(A,B: in std_logic_vector(7 downto 0);
			opSel: in std_logic_vector(2 downto 0);
			zero : out std_logic;
			AluOut: out std_logic_vector(7 downto 0));
	end component;
	
	component eightBitAdder
		port(i_a, i_b : in std_logic_vector(7 downto 0);
			i_cin : in std_logic;
			zero : out std_logic;
			o_cout : out std_logic;
			o_Value : out std_logic_vector(7 downto 0));
	end component;
	
	component mux2to1_8bit
		port(i_0   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_1   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_sel : IN  STD_LOGIC;
        o_y   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;
	
	component mux8to1_8bit
		port(i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7: in std_logic_vector(7 downto 0);
			i_sel: in std_logic_vector(2 downto 0);
			o_y: out std_logic_vector(7 downto 0));
	end component;
	
	component mux2to1_5bit
		port(i_0   : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_1   : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_sel : IN  STD_LOGIC;
        o_y   : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
	end component;
	
	component InstructionMem
		port(address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;
	
	component DataMem
		port(clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			rdaddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			rden		: IN STD_LOGIC  := '1';
			wraddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			wren		: IN STD_LOGIC  := '0';
			q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;
	
	component FileRegister
		port(RegWrite, GReset, GClock : in std_logic;
			readReg1, readReg2, writeReg : in std_logic_vector(2 downto 0);
			writeData : in std_logic_vector(7 downto 0);
			readData1, readData2 : out std_logic_vector(7 downto 0));
	end component;
	
	component eightBitRegister
		port(i_resetBar, i_load : IN STD_LOGIC;
        i_clock            : IN STD_LOGIC;
        i_Value            : IN STD_LOGIC_VECTOR(7 downto 0);
        o_Value            : OUT STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	component eightBitCompare
		port(i_Ai, i_Bi : in std_logic_vector(7 downto 0);
			equal : out std_logic);
	end component;
	
	component ControlUnit
		port(Inst : in std_logic_vector(5 downto 0);
			Zero : in std_logic;
			controlOut : out std_logic_vector(10 downto 0));
	end component;
	
	component ALUControl
		port(ALUOp : in std_logic_vector(1 downto 0);
			Funct : in std_logic_vector(5 downto 0);
			Operation : out std_logic_vector(2 downto 0));
	end component;
	
	component shiftLeft2_8bit
		port(i_value : in std_logic_vector(7 downto 0);
			o_value : out std_logic_vector(7 downto 0));
	end component;
	
	component hazardUnit
		port(memRead     : in std_logic;
        IDEX_rt     : in std_logic_vector(4 downto 0);
        IFID_rs     : in std_logic_vector(4 downto 0);
        IFID_rt     : in std_logic_vector(4 downto 0);
        stall       : out std_logic);
	end component;
	
	--Pipes
	component IFID_Pipe
		port(i_Flush, i_stall, i_enable, i_clk, GReset : in std_logic;
			PCplus4 : in std_logic_vector(7 downto 0);
			Instruction : in std_logic_vector(31 downto 0);
			o_PC : out std_logic_vector(7 downto 0);
			o_Instruction : out std_logic_vector(31 downto 0));
	end component;
	
	--Signals
	signal int_Inst : std_logic_vector(31 downto 0);
	signal int_PCSrc, int_PCOut, int_PCPlus, int_BTA, int_BTAMux, int_BranchMux : std_logic_vector(7 downto 0);
	signal int_FileR1, int_FileR2, int_ALUSrc, int_ALUresult, int_DataMem, int_MemOut : std_logic_vector(7 downto 0);
	signal int_RegDstMUX : std_logic_vector(4 downto 0);
	signal int_zeroFlag : std_logic;
	signal int_operation : std_logic_vector(2 downto 0);
	signal int_stall : std_logic;
	
	
	signal shiftedJump, effectiveAddr : std_logic_vector(7 downto 0);
	signal zeroBranchJump : std_logic;
	
	--signals from IFID pipe
	signal int_IFID_PC : std_logic_vector(7 downto 0);
	signal int_IFID_Inst : std_logic_vector(31 downto 0);
	
	--Signals from control unit
	signal ctrl_RegDst, ctrl_Brc, ctrl_MemR, ctrl_MtoR, ctrl_MemW, ctrl_RegW, ctrl_ALUsrc, ctrl_J : std_logic; --From control signals
	signal ctrl_ALUop : std_logic_vector(1 downto 0);
	
	signal int_ctrl : std_logic_vector(10 downto 0);
	
begin
	
	PC : eightBitRegister
		port map(i_resetBar => Greset,
			i_clock => Gclock,
			i_load => not(int_stall),
			i_Value => int_PCSrc,
			o_Value => int_PCOut);
			
	PC_plus_4 : eightBitAdder
		port map(i_a => int_PCOut,
			i_b => "00000100",			
			i_cin => '0',
			zero => open,
			o_cout => open,
			o_Value => int_PCPlus);
	
	InstMem : InstructionMem
		port map(address => int_PCOut,
			clock => Gclock,
			q => int_Inst);
			
	DataMemory : DataMem
		port map(clock => Gclock,
			data => int_FileR2,
			rdaddress => int_ALUresult(4 downto 0),
			rden => ctrl_MemR,
			wraddress => int_ALUresult(4 DOWNTO 0),
			wren => ctrl_MemW,
			q => int_DataMem);
	
	IFIDPipe : IFID_Pipe
		port map(i_Flush => int_ctrl(9), 
			i_stall => int_stall, 
			i_enable => '1', 
			i_clk => Gclock, 
			GReset => Greset,
			PCplus4 => int_PCPlus,
			Instruction => int_Inst,
			o_PC => int_IFID_PC,
			o_Instruction => int_IFID_Inst);
	
	ctrlUnit : ControlUnit
		port map(Inst => int_IFID_Inst(31 downto 26),
			Zero => '1',
			controlOut => int_ctrl);
	
	HazardDetect : hazardUnit
		port map(memRead => int_ctrl(5),
			IDEX_rt => "00000",
			IFID_rs => int_IFID_Inst(25 downto 21),
			IFID_rt => int_IFID_Inst(20 downto 16),
			stall => int_stall);
	
	shiftLeft2 : shiftLeft2_8bit
		port map(i_value => int_IFID_Inst(7 downto 0),
			o_value => shiftedJump);
	
	BranchJumpAdd : eightBitAdder
		port map(i_a => shiftedJump,
			i_b => int_PCPlus,
			i_cin => '0',
			zero => zeroBranchJump,
			o_cout => open,
			o_Value => effectiveAddr);
	
--	ALUControlUnit : ALUControl
--		port map(ALUOp => ctrl_ALUop,
--			Funct => int_Inst(5 downto 0),
--			Operation => int_operation);

	FileReg : FileRegister
		port map(GReset => Greset,
			GClock => Gclock,
			RegWrite => '0',
			readReg1 => int_IFID_Inst(23 downto 21),
			readReg2 => int_IFID_Inst(18 downto 16),
			writeReg => int_RegDstMUX(2 downto 0),
			writeData => int_MemOut,
			readData1 => int_FileR1,
			readData2 => int_FileR2);
--	

--
--	MemOut : mux2to1_8bit
--		port map(i_0 => int_DataMem,
--			i_1 => int_ALUresult,
--			i_sel => ctrl_MtoR,
--			o_y => int_MemOut);
--	
--	MuxOutMux : mux8to1_8bit
--		port map(i_0 => int_PCSrc,
--			i_1 => int_ALUresult,
--			i_2 => int_FileR1,
--			i_3 => int_FileR2,
--			i_4 => int_MemOut,
--			i_5 => "00000000",
--			i_6 => "00000000",
--			i_7 => "00000000",
--			i_sel => ValueSelect,
--			o_y => MuxOut);
--			
--	Zero <= int_zeroFlag;
--	MemWriteOut <= ctrl_MemW;
--	RegWriteOut <= ctrl_RegW;
--	BranchOut <= ctrl_Brc;
--	RegisterDst <= ctrl_RegDst;
--	MemoryToRegister <= ctrl_MtoR;
--	MemoryRead <= ctrl_MemR;
--	InstructionOut <= int_Inst;
--	ALUop1 <= ctrl_ALUop(0);
--	ALUop2 <= ctrl_ALUop(1);
--	JumpOut <= ctrl_J;
--	ALUSRC <= ctrl_ALUsrc;
--	
end rtl;