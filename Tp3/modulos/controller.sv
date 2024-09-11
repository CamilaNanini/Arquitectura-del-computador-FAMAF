// CONTROLLER

module controller(input logic [10:0] instr,
						input logic ExtIRQ,reset,ExcAck,
						output logic [3:0] AluControl,
						output logic reg2loc, regWrite,
						output logic [1:0] AluSrc,
						output logic Branch, memtoReg, memRead, memWrite,
						output logic ERet,Exc,ExtIAck,
						output logic [3:0] EStatus
						);
											
	logic [1:0] AluOp_s;
											
	maindec 	decPpal 	(.Op(instr), 
							.ExtIRQ(ExtIRQ),
							.Reset(reset),
							.ExcAck(ExcAck),
							.Reg2Loc(reg2loc), 
							.ALUSrc(AluSrc), 
							.MemtoReg(memtoReg), 
							.RegWrite(regWrite), 
							.MemRead(memRead), 
							.MemWrite(memWrite), 
							.Branch(Branch), 
							.ALUOp(AluOp_s),
							.ERet(ERet),
							.EStatus(EStatus),
							.Exc(Exc),
							.ExtIAck(ExtIAck)
							);	

								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(AluControl));
			
endmodule
