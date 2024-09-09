//MAINDEC

module maindec (input logic [10:0] Op,
					output logic Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,
					output logic [1:0] ALUOp);
always_comb
		begin
			casez(Op)
				11'b11111000010 : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b011110000; //LDUR
				11'b11111000000 : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b110001000; //STUR
				11'b10110100??? : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b100000101; //CBZ
				11'b10001011000 : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b000100010; //ADD
				11'b11001011000 : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b000100010; //SUB
				11'b10001010000 : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b000100010; //AND
				11'b10101010000 : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b000100010; //ORR
				default : {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} = 9'b0;
			endcase
		end
endmodule
