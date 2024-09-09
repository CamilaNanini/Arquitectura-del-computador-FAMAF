//MAINDEC

module maindec (input logic [10:0] Op,
					input logic ExtlRQ
					input logic reset,
					input logic ExcAck,
					output logic Reg2Loc,
					output logic [1:0] ALUSrc,
					output logic MemtoReg,RegWrite,MemRead,MemWrite,Branch,
					output logic [1:0] ALUOp,
					output logic ERet;
					output logic [3:0] EStatus;
					output logic Exc,ExtlAck
					);
					
logic NotAnInstr;
assign NotAnInstr = 0; //??
always_comb
		if (reset) begin
			Reg2Loc = 1'b0;
			ALUSrc = 2'b0;
			MemtoReg = 1'b0;
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUOp = 2'b0;
			Exc = 1'b0;
			EStatus = 3'b0;
		end
		else begin
			casez(Op)
				11'b11111000010 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b0_00_0_1_0_0_0_10_0_0000_0; //LDUR
				11'b11111000000 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b1_01_0_0_0_1_0_00_0_0000_0; //STUR
				11'b10110100??? : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b1_00_0_0_0_0_1_01_0_0000_0; //CBZ
				11'b10001011000 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b0_00_0_1_0_0_0_10_0_0000_0; //ADD
				11'b11001011000 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b0_00_0_1_0_0_0_10_0_0000_0; //SUB
				11'b10001010000 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b0_00_0_1_0_0_0_10_0_0000_0; //AND
				11'b10101010000 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b0_00_0_1_0_0_0_10_0_0000_0; //ORR
				//--------------------------NUEVAS INSTRUCCIONES--------------------------------
				11'b11010110100 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b0_00_0_0_0_0_1_01_1_0000_0; //ERET
				11'b11010101001 : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = 16'b1_10_0_1_0_0_0_01_0_0000_0; //MRS
				default : {Reg2Loc, ALUSrc[1:0], MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0],ERet,EStatus[3:0],NotAnInstr} = {11'b0}{0010}{1};
			endcase
			Exc = ExtIRQ | NotAnInstr;
		end
		//Si ExtIRQ = 1, EStatus[3..0] debe tomar el valor “0001”
		if(ExtIRQ) begin // Habria que hacer alguna comprobacion extra con Op?
			11'b??????????? : {EStatus[3:0]} = 0001;
		end
		//ExtIAck es ‘1’ cuando ExcAck = ‘1’ y ExtIRQ = ‘1’,
		if(ExcAck & ExtIRQ) begin
			ExtIAck = 1;
		end
	end
endmodule
