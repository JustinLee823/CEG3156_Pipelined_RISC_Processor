library ieee;
use ieee.std_logic_1164.all;

entity MEMWB_Pipe is
	port(i_MemtoReg, i_RegWrite, GReset, Gclock : in std_logic;
		o_MemtoReg, o_RegWrite : out std_logic;
		i_pipe: in std_logic_vector(25 downto 0);
		o_pipe: out std_logic_vector(25 downto 0)
		);
end entity;

architecture rtl of MEMWB_Pipe is

component enARdFF_2
PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
end component;

begin

MemtoReg: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(25), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(25)
			);


RegWrite: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(24), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(24)
			);


Mem7: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(23), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(23)
			);

			
			
Mem6: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(22), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(22)
			);
			
			
Mem5: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(21), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(21)
			);
			
			
			
Mem4: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(20), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(20)
			);
			
			
Mem3: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(19), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(19)
			);
			
			
Mem2: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(18), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(18)
			);
			
			
			
Mem1: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(17), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(17)
			);

			
Mem0: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(16), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(16)
			);
			

R7: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(15), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(15)
			);
			
R6: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(14), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(14)
			);
			
			
R5: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(13), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(13)
			);
			
R4: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(12), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(12)
			);
			
			
R3: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(11), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(11)
			);
			
			
R2: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(10), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(10)
			);
			
			
R1: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(9), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(9)
			);
			
			
R0: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(8), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(8)
			);
			
			
RD7: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(7), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(7)
			);

			
RD6: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(6), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(6)
			);
			
RD5: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(5), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(5)
			);
			
			
RD4: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(4), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(4)
			);
			
			
RD3: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(3), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(3)
			);
			
			
RD2: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(2), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(2)
			);
			
			
RD1: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(1), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(1)
			);
			
			
RD0: enARdFF_2
port map(i_resetBar => GReset,
			i_d =>i_pipe(0), 
			i_enable =>'1',
			i_clock => Gclock,
			o_q => o_pipe(0)
			);
			
			

end rtl;
