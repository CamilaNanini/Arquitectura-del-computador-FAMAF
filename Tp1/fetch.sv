//Fetch

module fetch #(parameter N = 64) 
				(input logic PCSrc_F,clk,reset,
				  input logic[N-1:0]PCBranch_F,
				  output logic[N-1:0]imem_addr_F
				  );
logic [N-1:0] resadder;
logic [N-1:0] resmux;
mux2 dut1 (resadder,PCBranch_F,PCSrc_F,resmux);
flopr dut2 (clk,reset,resmux,imem_addr_F);
adder dut3 (imem_addr_F, 64'd4,resadder);
endmodule
