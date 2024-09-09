module execute_tb();
	parameter N=64;
	logic AluSrc;
   logic [3:0] AluControl;
	logic [N-1:0] PC_E,signImm_E, readData1_E, readData2_E, PCBranch_E, aluResult_E, writeData_E;
	logic zero_E;
	logic [192:0] resultexpected;
	logic [31:0] counterrors;
	
	execute #(N) dut(AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E, zero_E, PCBranch_E, aluResult_E, writeData_E);
	
	initial begin
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b1,64'b1,64'b1,64'b1, 64'b1};#10ns;
		check_execute("Test 1",{1'b0,64'd5,64'b1,64'b1});
		
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b0,64'b1,64'b1,64'b0, 64'b1};#10ns;
		check_execute("Test 2",{1'b1,64'd5,64'b0,64'b1});
		
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b0,4'b1,64'b1,64'b1,64'b1, 64'b10};#10ns;
		check_execute("Test 3",{1'b0,64'd5,64'b11,64'b10});
		
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b1,64'b1,64'b10,64'b1, 64'b1};#10ns;
		check_execute("Test 4",{1'b0,64'd9,64'b11,64'b1});
		
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b0,4'b111,64'b1,64'b1,64'b1, 64'b10};#10ns;
		check_execute("Test 5",{1'b0,64'd5,64'b10,64'b10});
		
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b10,64'b1,64'b1,64'b1, 64'b1};#10ns;
		check_execute("Test 6",{1'b0,64'd5,64'b10,64'b1});
		
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b110,64'b1,64'b1,64'b1,64'b1};#10ns;
		check_execute("Test 7",{1'b1,64'd5,64'd0,64'b1});
		
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b10,64'b1,64'b1,64'hFFFFFFFFFFFFFFFE,64'b1};#10ns;
		check_execute("Test 8",{1'b0,64'd5,64'hFFFFFFFFFFFFFFFF,64'b1});
	end

	function void check_execute(input string s,input [192:0] resultexpected);
	if({zero_E, PCBranch_E, aluResult_E, writeData_E} !== resultexpected) begin
			$display("Error from %s",s);
			$display("Output = %b",zero_E, PCBranch_E, aluResult_E, writeData_E);
			$display("Output expected = %b",resultexpected);
			counterrors = counterrors + 1;
		end 
		else begin
			$display("Op %s ------ok------",s);
	  end
	endfunction
endmodule