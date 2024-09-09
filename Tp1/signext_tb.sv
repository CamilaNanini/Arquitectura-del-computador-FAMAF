module signext_tb();
	logic clk, reset;
	logic [31:0] a;
	logic [63:0] y, yexpected;
	logic [31:0] error, index;
	// array of testvectors
	logic [95:0] testvector [0:9]= '{
	 //		 opcode     DT_Addr  op  Rn    Rt   yexpected
		{32'b11111000010_000000001_00_00001_00000, 64'h1},   			     // LDUR con inmediato positivo
		{32'b11111000010_100000000_00_00001_00000, 64'hffffffffffffff00},  // LDUR con inmediato negativo
		{32'b11111000000_000000001_00_00001_00000, 64'h1},   			     // STUR con inmediato positivo
		{32'b11111000000_100000000_00_00001_00000, 64'hffffffffffffff00},  // SDUR con inmediato negativo
	//        opcode     COND_BR_Addr     Rt      yexpected
		{32'b10110100000_0000000000000001_00000, 64'h4}, // CBZ con inmediato positivo y condicion sin cuidado 0´s
		{32'b10110100111_0000000000000001_00000, 64'h1c0004}, // CBZ con inmediato positivo y condicion sin cuidado 1´s
		{32'b10110100000_1000000000000000_00000, 64'h20000}, // CBZ con inmediato negativo y condicion sin cuidado 0´s
		{32'b10110100111_1000000000000000_00000, 64'h1e0000}, // CBZ con inmediato negativo y condicion sin cuidado 1´ss
	// Instrucciones que no pertenecen = salida 0
		{32'b00111000010_000000001_00_00001_00000, 64'h0}, // LDURB
		{32'b10001011000_00001_000100_00001_00010, 64'h0} // ADD
		};
	
	initial  begin
		error = 0;
		index = 0;
		reset = 1;
		#27 reset = 0;
	end
	
	signext dup(a, y);
	
	always 
		begin
			clk = 0; #5; clk = 1; #5;
		end
	
	
	always @(posedge clk)
		begin
			#1 {a,yexpected} = testvector[index];
		end
   
	always @(negedge clk)
	if (!reset) begin
			if (y !== yexpected) 
				begin  
					$display("Error: inputs = %b", a);
					$display("outputs = %b (%b expected)",y,yexpected);
					error = error + 1;
				end
      	index = index + 1;
			if (testvector[index] === 96'bx) 
				begin
					$display("Errors :%d ,tests finished succesfully", error);
					$stop;
				end
end
endmodule
	