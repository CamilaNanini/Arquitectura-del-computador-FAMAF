//Execute

module execute #(parameter N = 64) 
					(input logic AluSrc,
					 input logic [3:0] AluControl,
					 input logic [N-1:0] PC_E,signImm_E,readData1_E,readData2_E,
					 output logic [N-1:0] PCBranch_E,aluResult_E,writeData_E,
					 output logic zero_E
					 );

logic [N-1:0] resmux;
logic [N-1:0] resshift;
mux2 dut1 (readData2_E,signImm_E,AluSrc,resmux);
assign writeData_E = readData2_E;
alu dut2 (readData1_E,resmux,AluControl,aluResult_E,zero_E);
sl2 dut3 (signImm_E,resshift);
adder dut4 (resshift,PC_E,PCBranch_E);
endmodule
//alu, sl2, adder y mux2
