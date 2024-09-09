module flopr_tb();
	logic clk, reset;
	logic [63:0] d,q,qant;
	logic [31:0] index,error;
	logic [127:0] vector_d_qant [0:9] = '{
	{64'h1,64'h0},{64'h2,64'h1},{64'h3,64'h2},{64'h4,64'h3},{64'h5,64'h4},{64'h6,64'h5},{64'h7,64'h6},
	{64'h8,64'h7},{64'h9,64'h8},{64'h10,64'h9}
	};

	always
		begin
			clk = 1; #5ns; clk = 0; #5ns;
		end
		
	initial
		begin 
			index = 0;
			error = 0;
			q = 0;
			reset = 1;
			#50ns reset = 0;
		end
		
	flopr #(64) dut (clk, reset, d, q);
	
	always @(posedge clk)
		begin
			#1 {d,qant} = vector_d_qant[index];
			if(reset === 0) begin
				qant = 0;
			end
		end
		
	always @(negedge clk)
		begin
			if (!reset) begin
				#1;if(q!==qant) begin
					$display("\n===Error===");
					$display("Error: inputs = %b", d);
					$display("outputs = %b (%b expected)",q,qant);
					$display("reset: %d", reset);
					$display("clock: %d", clk);
					error = error +1;
				end
			end
			index = index + 1;
			if (vector_d_qant[index] === 128'bx) begin 
				$display("Tests completed with %d errors",error);
				$stop;
			end
		end
endmodule
