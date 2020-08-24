module decoder(
    input [3:0] op,
    input fetch,
    input exec1,
    input exec2,
    input EQ,
    input MI,
	 input FIB_Ready,
	 input LCG_Ready,
    input LKL_Ready,
	 input count_en,
    output Extra,
    output Reset,
	 output Loop,
    output [11:0] control_port,
	 output LCG_sig,
	 output LKL_sig

);

wire LDA, STA, ADD, SUB, JMP, JMI, JEQ, STP, LDI, LSR, LSL, FIB, LCG, LKL;

assign LDA = ~op[3] & ~op[2] & ~op[1] & ~op[0];
assign STA = ~op[3] & ~op[2] & ~op[1] &  op[0];
assign ADD = ~op[3] & ~op[2] &  op[1] & ~op[0];
assign SUB = ~op[3] & ~op[2] &  op[1] &  op[0];
assign JMP = ~op[3] &  op[2] & ~op[1] & ~op[0];
assign JMI = ~op[3] &  op[2] & ~op[1] &  op[0];
assign JEQ = ~op[3] &  op[2] &  op[1] & ~op[0];
assign STP = ~op[3] &  op[2] &  op[1] &  op[0];
assign LDI =  op[3] & ~op[2] & ~op[1] & ~op[0];
assign LSL =  op[3] & ~op[2] & ~op[1] &  op[0];
assign LSR =  op[3] & ~op[2] &  op[1] & ~op[0];
assign FIB =  op[3] & ~op[2] &  op[1] &  op[0];
assign LCG =  op[3] &  op[2] & ~op[1] & ~op[0];
assign LKL =  op[3] &  op[2] & ~op[1] &  op[0];

//assign the extra bit
assign Extra = LDA & exec1 | ADD & exec1 | SUB & exec1 | FIB & exec1 | LKL & exec1;
//assign the control sig which controls the FIB instr.
assign Reset = ~(FIB & exec1);
//assign the loop signal which controls the state machine
assign Loop = FIB & exec1 & ~FIB_Ready | LCG & exec1 & ~LCG_Ready | LKL & exec1 & ~LKL_Ready;
//control the LCG
assign LCG_sig = LCG & exec1;
//control the LKL
assign LKL_sig = LKL & exec1;
//RAM_data wren
assign control_port[0] = STA & exec1 | FIB & exec2 & Reset;
//IR_enable and MUX2 sel
assign control_port[1] = exec1 & ~count_en;
//PC_cnt_en
assign control_port[2] = LDA & exec2 | STA & exec1 | ADD & exec2 | SUB & exec2 | JMI & ~MI & exec1 | JEQ & ~EQ & exec1 | LDI & exec1 | LSR & exec1 | FIB & exec2 | LCG & exec1 & LCG_Ready | LKL & exec2;
//PC_sload
assign control_port[3] = JMP & exec1 | JMI & MI & exec1 | JEQ & EQ & exec1;
//ALU_add_sub
assign control_port[4] = ADD & exec2 | LSL & exec1;
//ACC_enable
assign control_port[5] = LDA & exec2 | ADD & exec2 | SUB & exec2 | LDI & exec1 | LSR & exec1 | LKL & exec2 | LSL & exec1;
//ACC_shiftin
assign control_port[6] = 0; //ASR & exec1
//ACC_load
assign control_port[7] = LDA & exec2 | ADD & exec2 | SUB & exec2 | LDI & exec1 | LKL & exec2 | LSL & exec1;
//MUX1 sel
assign control_port[8] = LDA & exec1 | STA & exec1 | ADD & exec1 | SUB & exec1 | JMP & exec1 | JEQ & EQ & exec1 | JMI & MI & exec1 | LKL & exec1;
//LSL
assign control_port[9] = LSL & exec1;
//MUX3 sel
assign control_port[10] = LDA & exec2 | LDI & exec1;
//LDA_Sig (Control LDA or LDI)
assign control_port[11] = LDA & exec2;

endmodule

