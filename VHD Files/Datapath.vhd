library ieee;
use ieee.std_logic_1164.all;

entity Datapath is
	port(
		Greset, Gclock : in std_logic;
		ValueSelect : in std_logic_vector(2 downto 0);
		o_IDEXControl : out std_logic_vector(9 downto 0);
		o_Control : out std_logic_vector(10 downto 0);
		o_compareVal : out std_logic;
		InstructionOut : out std_logic_vector(31 downto 0);
		MuxOut, o_mux1, o_mux2 : out std_logic_vector(7 downto 0);
		temp : out std_logic);
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
	
	component mux2to1_11bit
		PORT(i_0   : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
        i_1   : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
        i_sel : IN  STD_LOGIC;
        o_y   : OUT STD_LOGIC_VECTOR(10 DOWNTO 0));
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
	
	component mux4to1_8bit
		port(i_0,i_1,i_2,i_3: in std_logic_vector(7 downto 0);
			i_sel: in std_logic_vector(1 downto 0);
			o_y: out std_logic_vector(7 downto 0));
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
        stall, PCWrite       : out std_logic);
	end component;
	
	component forwardingUnit
		port(EXMEM_RegWrite      : in std_logic;
        EXMEM_RegisterRd    : in std_logic_vector(4 downto 0);
        IDEX_RegisterRs     : in std_logic_vector(4 downto 0);
        IDEX_RegisterRt     : in std_logic_vector(4 downto 0);

        MEMWB_RegWrite      : in std_logic;
        MEMWB_RegisterRd    : in std_logic_vector(4 downto 0);

        ForwardA    : out std_logic_vector(1 downto 0);
        ForwardB    : out std_logic_vector(1 downto 0));
	end component;
	
	--Pipes
	component IFID_Pipe
		port(i_Flush, i_stall, i_enable, i_clk, GReset : in std_logic;
			PCplus4 : in std_logic_vector(7 downto 0);
			Instruction : in std_logic_vector(31 downto 0);
			o_PC : out std_logic_vector(7 downto 0);
			o_Instruction : out std_logic_vector(31 downto 0));
	end component;
	
	component IDEX_Pipe
		port(ReadData1, ReadData2 : in std_logic_vector(7 downto 0);
			RS, RT, RD : in std_logic_vector(4 downto 0);
			Instruction15_0 : in std_logic_vector(15 downto 0);
			i_ALUOp : in std_logic_vector(1 downto 0);
			i_RegDst, i_Branch, i_MemRead, i_MemtoReg, i_MemWrite, i_RegWrite, i_ALUSrc, i_Jump, i_clk, i_reset : in std_logic;
			o_ReadData1, o_ReadData2 : out std_logic_vector(7 downto 0);
			o_RS, o_RT, o_RD : out std_logic_vector(4 downto 0);
			o_Instruction15_0 : out std_logic_vector(15 downto 0);
			o_RegDst, o_Branch, o_MemRead, o_MemtoReg, o_MemWrite, o_RegWrite, o_ALUSrc, o_Jump : out std_logic;
			o_ALUOp : out std_logic_vector(1 downto 0));
	end component;	
	
	component EXMEM_Pipe
		port(
			ALUResult, i_readData2 : in std_logic_vector(7 downto 0);
			i_rt : in std_logic_vector(4 downto 0); --, i_rd
			i_Branch, i_MemRead, i_MemWrite, i_MemtoReg, i_RegWrite, i_reset, i_clk : in std_logic;
			o_ALUResult, o_readData2 : out std_logic_vector(7 downto 0);
			o_rt : out std_logic_vector(4 downto 0); --, o_rd
			o_Branch, o_MemRead, o_MemWrite, o_MemtoReg, o_RegWrite : out std_logic);
	end component;
	
	component MEMWB_Pipe
		port(i_MemtoReg, i_RegWrite, GReset, Gclock : in std_logic;
			i_RTRD : in std_logic_vector(4 downto 0);
			i_dataMem, i_ALUresult : in std_logic_vector(7 downto 0);
			MEMWB_RTRD : out std_logic_vector(4 downto 0);
			MEMWB_dataMemOut, MEMWB_ALUresult : out std_logic_vector(7 downto 0);
			MEMWB_MemtoReg, MEMWB_RegWrite : out std_logic);
	end component;
	
	--Signals
	signal int_Inst : std_logic_vector(31 downto 0);
	signal int_PCSrc, int_PCOut, int_PCPlus, int_BTA, int_BTAMux, int_BranchMux : std_logic_vector(7 downto 0);
	signal int_FileR1, int_FileR2, int_ALUSrc, int_DataMem : std_logic_vector(7 downto 0);
	signal int_RegDstMUX : std_logic_vector(4 downto 0);
	signal int_stall, int_PCWrite : std_logic;


	signal int_ALUresult, int_MemOut : std_logic_vector(7 downto 0);
	signal int_operation : std_logic_vector(2 downto 0);
	signal int_zeroFlag, int_compare : std_logic;
	
	signal shiftedJumpBranch, effectiveAddr, RSMuxOut, RTMuxOut : std_logic_vector(7 downto 0);
	signal mysticalMuxOut : std_logic_vector(4 downto 0);
	signal zeroBranchJump : std_logic;
	
	--signals for IFID pipe
	signal int_IFID_PC : std_logic_vector(7 downto 0);
	signal int_IFID_Inst : std_logic_vector(31 downto 0);
	
	--signals for IDEX pipe
	signal IDEX_Inst : std_logic_vector(15 downto 0);
	signal IDEX_muxOut : std_logic_vector(10 downto 0);
	signal IDEX_readData1, IDEX_readData2 : std_logic_vector(7 downto 0);
	signal IDEX_RS, IDEX_RT, IDEX_RD : std_logic_vector(4 downto 0);
	signal IDEX_RegDst, IDEX_Branch, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_RegWrite, IDEX_ALUSrc, IDEX_Jump : std_logic;
	signal IDEX_ALUOp : std_logic_vector(1 downto 0);
	
	--signals for EXMEM pipe
	signal EXMEM_ALUresult, EXMEM_ReadData2 : std_logic_vector(7 downto 0);
	signal EXMEM_RTRD : std_logic_vector(4 downto 0);
	signal INTEXMEM_Branch, INTEXMEM_MemRead, INTEXMEM_MemWrite, INTEXMEM_MemtoReg, INTEXMEM_RegWrite : std_logic;
	
	--signals for MEMWB pipe
	signal INTMEMWB_RegWrite, INTMEMWB_MemtoReg : std_logic;
	signal INTMEMWB_RTRD : std_logic_vector(4 downto 0);
	signal INTMEMWB_ALUresult, INTMEMWB_DataMemOut : std_logic_vector(7 downto 0);
	
	
	--signals from forwarding unit
	signal int_forwardA, int_forwardB : std_logic_vector(1 downto 0);
	
	--Signals from control unit
	signal ctrl_RegDst, ctrl_Brc, ctrl_MemR, ctrl_MtoR, ctrl_MemW, ctrl_RegW, ctrl_ALUsrc, ctrl_J : std_logic; --From control signals
	signal ctrl_ALUop : std_logic_vector(1 downto 0);
	
	--signals from data memoryRead
	signal dataMemOut : std_logic_vector(7 downto 0);
	
	signal int_ctrl : std_logic_vector(10 downto 0);
	
begin
	
	o_Control <= int_ctrl;
	o_compareVal <= int_compare;
	
	o_mux1 <= RSMuxOut;
	o_mux2 <= RTMuxOut;
	
	PC : eightBitRegister
		port map(i_resetBar => Greset,
			i_clock => Gclock,
			i_load => int_PCWrite,
			i_Value => int_PCSrc,
			o_Value => int_PCOut);
			
	PC_plus_4 : eightBitAdder
		port map(i_a => int_PCOut,
			i_b => "00000100",			
			i_cin => '0',
			zero => open,
			o_cout => open,
			o_Value => int_PCPlus);
	
	PCMux : mux2to1_8bit 
		port map(i_0 => int_PCPlus,
			i_1 => effectiveAddr,
			i_sel => int_ctrl(4) and int_compare, -- and zeroBranchJump
			o_y => int_PCSrc);
	
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
		port map(memRead => IDEX_MemRead,
			IDEX_rt => IDEX_RT,
			IFID_rs => int_IFID_Inst(25 downto 21),
			IFID_rt => int_IFID_Inst(20 downto 16),
			stall => int_stall,
			PCWrite => int_PCWrite);
	
	shiftLeft2 : shiftLeft2_8bit
		port map(i_value => int_IFID_Inst(7 downto 0),
			o_value => shiftedJumpBranch);
	
	BranchJumpAdd : eightBitAdder
		port map(i_a => shiftedJumpBranch,
			i_b => int_PCPlus,
			i_cin => '0',
			zero => zeroBranchJump,
			o_cout => open,
			o_Value => effectiveAddr);
	
	IDEXMux : mux2to1_11bit
		port map(i_0 => int_ctrl,
        i_1 => "00000000000",
        i_sel => int_stall,
        o_y => IDEX_muxOut);
	
	ALUControlUnit : ALUControl
		port map(ALUOp => IDEX_ALUOp,
			Funct => int_Inst(5 downto 0),
			Operation => int_operation);

	FileReg : FileRegister
		port map(GReset => Greset,
			GClock => Gclock,
			RegWrite => INTMEMWB_RegWrite,
			readReg1 => int_IFID_Inst(23 downto 21),
			readReg2 => int_IFID_Inst(18 downto 16),
			writeReg => int_RegDstMUX(2 downto 0),
			writeData => int_MemOut,
			readData1 => int_FileR1,
			readData2 => int_FileR2);
	
	comparator : eightBitCompare
		port map(i_Ai => int_FileR1, 
			i_Bi => int_FileR2,
			equal => int_compare);
	
	
	IDEXPipe : IDEX_Pipe
		port map(ReadData1 => int_FileR1, 
			ReadData2 => int_FileR2,
			RS => int_IFID_Inst(25 downto 21),
			RT => int_IFID_Inst(20 downto 16), 
			RD => int_IFID_Inst(15 downto 11),
			Instruction15_0 => int_IFID_Inst(15 downto 0),
			i_RegDst => IDEX_muxOut(0),
			i_ALUOp(0) => IDEX_muxOut(1),
			i_ALUOp(1) => IDEX_muxOut(2), 
			i_ALUSrc => IDEX_muxOut(3),
			i_Branch => IDEX_muxOut(4), 
			i_MemRead => IDEX_muxOut(5),
			i_MemWrite => IDEX_muxOut(6),	
			i_MemtoReg => IDEX_muxOut(7), 		 
			i_RegWrite => IDEX_muxOut(8),  
			i_Jump => IDEX_muxOut(10), 
			i_clk => Gclock, 
			i_reset => Greset,
			o_ReadData1 => IDEX_readData1, 
			o_ReadData2 => IDEX_readData2,
			o_RS => IDEX_RS,
			o_RT => IDEX_RT, 
			o_RD => IDEX_RD,
			o_RegDst => IDEX_RegDst, 
			o_Branch => IDEX_Branch, 
			o_MemRead => IDEX_MemRead, 
			o_MemtoReg => IDEX_MemtoReg, 
			o_MemWrite => IDEX_MemWrite, 
			o_RegWrite => IDEX_RegWrite, 
			o_ALUSrc => IDEX_ALUSrc, 
			o_Jump => IDEX_Jump,
			o_ALUOp(0) => IDEX_ALUOp(0),
			o_ALUOp(1) => IDEX_ALUOp(1),
			o_Instruction15_0 => IDEX_Inst);
	
	RSmux : mux4to1_8bit
		port map(i_0 => IDEX_readData1,
			i_1 => int_MemOut, --write back mux output
			i_2 => EXMEM_ALUresult,
			i_3 => "00000000", --Open
			i_sel => int_forwardA, --forwarding
			o_y => RSMuxOut);
			
	RTmux : mux4to1_8bit
		port map(i_0 => IDEX_readData2,
			i_1 => int_MemOut, --write back mux output
			i_2 => EXMEM_ALUresult,
			i_3 => "00000000", --Open
			i_sel => int_forwardB, --forwarding
			o_y => RTMuxOut);
			
	MysticalMux : mux2to1_5bit
		port map(i_0 => IDEX_RT,
			i_1 => IDEX_RD,
			i_sel => IDEX_RegDst, --Mystical selector
			o_y => mysticalMuxOut);
	
	ALU : ALU8bit
		port map(A => RSMuxOut,
			B => RTMuxOut,
			opSel => int_operation,
			zero => int_zeroFlag,
			AluOut => int_ALUresult);
	
	ForwardUnitBlock : forwardingUnit
		port map(EXMEM_RegWrite => INTEXMEM_RegWrite,
        EXMEM_RegisterRd => EXMEM_RTRD,
        IDEX_RegisterRs => IDEX_RS,
        IDEX_RegisterRt => IDEX_RT,

        MEMWB_RegWrite => INTMEMWB_RegWrite,
        MEMWB_RegisterRd => INTMEMWB_RTRD,

        ForwardA => int_forwardA,
        ForwardB => int_forwardB);
	
	EXMEMPipe : EXMEM_Pipe
		port map(ALUResult => int_ALUresult,
			i_readData2 => IDEX_readData2,
			i_rt => mysticalMuxOut, 
			i_Branch => IDEX_Branch, 
			i_MemRead => IDEX_MemRead, 
			i_MemWrite => IDEX_MemWrite, 
			i_MemtoReg => IDEX_MemtoReg, 
			i_RegWrite => IDEX_RegWrite, 
			i_reset => Greset, 
			i_clk => Gclock,
			o_ALUResult => EXMEM_ALUresult,
			o_readData2 => EXMEM_ReadData2,
			o_rt => EXMEM_RTRD, 
			o_Branch => INTEXMEM_Branch, 
			o_MemRead => INTEXMEM_MemRead, 
			o_MemWrite => INTEXMEM_MemWrite, 
			o_MemtoReg => INTEXMEM_MemtoReg, 
			o_RegWrite => INTEXMEM_RegWrite);
	
	DataMemoryBlock : DataMem
		port map(clock => Gclock,
			data => EXMEM_ReadData2,
			rdaddress => EXMEM_ALUresult(4 downto 0),
			rden => INTEXMEM_MemRead,
			wraddress => EXMEM_ALUresult(4 downto 0),
			wren => INTEXMEM_MemWrite,
			q => dataMemOut);
			
	MEMWBPipe : MEMWB_Pipe
		port map(i_MemtoReg => INTEXMEM_MemtoReg, 
			i_RegWrite => INTEXMEM_RegWrite, 
			GReset => Greset, 
			Gclock => Gclock,
			i_RTRD => EXMEM_RTRD,
			i_dataMem => dataMemOut, 
			i_ALUresult => EXMEM_ALUresult,
			MEMWB_RTRD => INTMEMWB_RTRD,
			MEMWB_dataMemOut => INTMEMWB_DataMemOut, 
			MEMWB_ALUresult => INTMEMWB_ALUresult,
			MEMWB_MemtoReg => INTMEMWB_MemtoReg, 
			MEMWB_RegWrite => INTMEMWB_RegWrite);
	
	writebackMux : mux2to1_8bit
		port map(i_0 => dataMemOut,
        i_1 => INTMEMWB_ALUresult,
        i_sel => INTMEMWB_MemtoReg,
        o_y => int_MemOut);
		  
	o_IDEXControl(0) <= IDEX_RegDst;
	o_IDEXControl(1) <= IDEX_ALUOp(0);
	o_IDEXControl(2) <= IDEX_ALUOp(1);
	o_IDEXControl(3) <= IDEX_ALUSrc;
	o_IDEXControl(4) <= IDEX_Branch;
	o_IDEXControl(5) <= IDEX_MemRead;
	o_IDEXControl(6) <= IDEX_MemWrite;
	o_IDEXControl(7) <= IDEX_MemtoReg;
	o_IDEXControl(8) <= IDEX_RegWrite;
	o_IDEXControl(9) <= IDEX_Jump;
	
	temp <= int_stall;
	InstructionOut <= int_Inst;
	MuxOut <= int_MemOut;
	
end rtl;