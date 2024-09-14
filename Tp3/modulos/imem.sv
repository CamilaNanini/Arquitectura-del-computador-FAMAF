// INSTRUCTION MEMORY

module imem #(parameter N=32)
			 (input logic [6:0] addr,
			  output logic [N-1:0] q);

	logic [N-1:0] ROM [0:1]; // [0:127]
	
	initial
	begin	
		ROM  = '{32'h8b010000,
					32'h8b010000};	
		// Código ensamblado:

	end
	
	assign q = ROM[addr];
endmodule
