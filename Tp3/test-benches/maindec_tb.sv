module maindec_tb();
logic [10:0] Op;
logic Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch;
logic [1:0] ALUOp;
logic [31:0] counterrors;
logic [8:0] resultexpected;

maindec dut (Op,Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp);

initial 
begin
 #10
 counterrors = 0;
 Op = 11'b11111000010; //LDUR
 resultexpected = 9'b011110000;
 #10
 check_maindec("Op = LDUR",resultexpected);
 
 Op = 11'b11111000000; //STUR 
 resultexpected = 9'b110001000;
 #10
 check_maindec("Op = STUR",resultexpected);
 
 Op = 11'b101_1010_0???; //CBZ 
 resultexpected = 9'b100000101;
 #10
 check_maindec("Op = CBZ",resultexpected);
 
 Op = 11'b10001011000; //ADD 
 resultexpected = 9'b000100010;
 #10
 check_maindec("Op = ADD",resultexpected);
 
 Op = 11'b11001011000; //SUB 
 resultexpected = 9'b000100010;
 #10
 check_maindec("Op = SUB",resultexpected);
 
 Op = 11'b10001010000; //AND
 resultexpected = 9'b000100010;
 #10
 check_maindec("Op = AND",resultexpected);
 
 Op = 11'b10101010000; //ORR 
 resultexpected = 9'b000100010;
 #10
 check_maindec("Op = ORR",resultexpected);
 
 Op = 11'b10101011010; //Other op
 resultexpected = 9'b0;
 #10
 check_maindec("Op = Other",resultexpected);
$display("Tests ends white errors = %d",counterrors);
end

function void check_maindec(input string s,input [8:0] resultexpected);
	if({Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp} !== resultexpected)
		begin
			$display("Error from %s",s);
			$display("Output = %b",Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp);
			$display("Output expected = %b",resultexpected);
			counterrors = counterrors + 1;
		end 
		else begin
			$display("Op %s ------ok------",s);
	  end
endfunction

endmodule