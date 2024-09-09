module alu_tb();
	logic clk, reset;
	logic [63:0] a,b,result,resultexpected;
	logic zero;
	logic [3:0] Alucontrol;
	logic [31:0] error, index_values, index_result, index_alucontrol;

				
logic [127:0] values_array [0:3]= '{
		{64'ha, 64'h1},                  			       // Positivos
		{64'hf000000000000000, 64'h9000000000000001},    // Negativos y Overflow  en suma
		{64'h2, 64'h9000000000000001},   			       // Positivo y negativo
		{64'h0, 64'h0} 						                // Flag 0
		};
	logic [3:0] values_alucontrol [0:4] ='{{4'd0},{4'd1},{4'd2},{4'd6},{4'd7}};
	logic [63:0] results_array [0:19]= '{
	{64'h0},{64'h9000000000000000},{64'h0},{64'h0},// And
	{64'hb},{64'hf000000000000001},{64'h9000000000000003},{64'h0},// Or
	{64'hb},{64'h8000000000000001},{64'h9000000000000003},{64'h0}, //Sumas //Falta un 1 en el res 2
	{64'h9},{64'h5fffffffffffffff},{64'h7000000000000001},{64'h0}, //Restas
	{64'h1},{64'h9000000000000001},{64'h9000000000000001},{64'h0} //Pass
	};
	
initial  begin
	error = 0;
	index_values = 0;
	index_result = 0;
	index_alucontrol = 0;
	reset = 1;
	#27 reset = 0;
end

always begin
		clk = 0; #5; clk = 1; #5;
end

alu dut(a,b,Alucontrol,result,zero);

always @(posedge clk)
	begin
			#1 {a,b} = values_array[index_values];
			{Alucontrol} = values_alucontrol[index_alucontrol];
			{resultexpected} = results_array[index_result];
	end
	
always @(negedge clk)
	if (!reset) begin
			if (result !== resultexpected) 
				begin  
					$display("Error: inputs = %b , %b", a,b);
					$display("outputs = %b (%b expected)",result,resultexpected);
					$display("Alucontrol = %b",values_alucontrol [index_alucontrol]);
					error = error + 1;
				end
      	index_values = index_values + 1;
			index_result = index_result +1;
			if((index_result === 3)|(index_result === 7)|(index_result === 11)|(index_result === 15)|(index_result === 15)) begin  
				index_alucontrol = index_alucontrol + 1;
				index_values = 0;
			end
			if((zero === 1) & (result!==0)) begin  
					$display("Errorr form zero = %b ",zero);
					error = error + 1;
				end
			if (values_alucontrol[index_alucontrol] === 4'bx & results_array[index_result] === 64'bx) 
				begin
					$display("Errors :%d ,tests finished succesfully", error);
					$stop;
				end
	end

endmodule

/*Test bobo
initial  begin
 #10 
 a=64'd0;b=64'd0;Alucontrol = 4'd0; resultexpected = 64'h0; 
 #20
	if (result !== resultexpected) 
				begin  
					$display("Error: inputs = %b , %b", a,b);
					$display("outputs = %b (%b expected)",result,resultexpected);
					$display("Alucontrol = %b",Alucontrol);
				end
	if((zero === 1) && (result!==0)) begin  
					$display("Errorr form zero = %b ",zero);
				end
#10 
 a=64'd0;b=64'd0;Alucontrol = 4'd1; resultexpected = 64'h0; 
 #20
	if (result !== resultexpected) 
				begin  
					$display("Error: inputs = %b , %b", a,b);
					$display("outputs = %b (%b expected)",result,resultexpected);
					$display("Alucontrol = %b",Alucontrol);
				end
	if((zero === 1) && (result!==0)) begin  
					$display("Errorr form zero = %b ",zero);
				end
#10 
 a=64'd0;b=64'd0;Alucontrol = 4'd2; resultexpected = 64'h0; 
 #20
	if (result !== resultexpected) 
				begin  
					$display("Error: inputs = %b , %b", a,b);
					$display("outputs = %b (%b expected)",result,resultexpected);
					$display("Alucontrol = %b",Alucontrol);
				end
	if((zero === 1) && (result!==0)) begin  
					$display("Errorr form zero = %b ",zero);
				end
#10 
 a=64'd0;b=64'd0;Alucontrol = 4'd6; resultexpected = 64'h0; 
 #20
	if (result !== resultexpected) 
				begin  
					$display("Error: inputs = %b , %b", a,b);
					$display("outputs = %b (%b expected)",result,resultexpected);
					$display("Alucontrol = %b",Alucontrol);
				end
	if((zero === 1) && (result!==0)) begin  
					$display("Errorr form zero = %b ",zero);
				end
#10 
 a=64'd0;b=64'd0;Alucontrol = 4'd7; resultexpected = 64'h0; 
 #20
	if (result !== resultexpected) 
				begin  
					$display("Error: inputs = %b , %b", a,b);
					$display("outputs = %b (%b expected)",result,resultexpected);
					$display("Alucontrol = %b",Alucontrol);
				end
	if((zero === 1) && (result!==0)) begin  
					$display("Errorr form zero = %b ",zero);
				end
end
*/