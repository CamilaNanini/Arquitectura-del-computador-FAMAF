//SIGNEXT

module signext #(parameter N = 64)
					(input logic [31:0] a,
					output logic [N-1:0] y);
always_comb 
	begin
    casez (a[31:21])
		  default: y = 0;
        11'b111_1100_0010: y = {{(N-9){a[20]}},a[20:12]};
        11'b111_1100_0000: y = {{(N-9){a[20]}},a[20:12]};
		  11'b101_1010_0???: y = {{(N-19){a[18]}},a[23:5]};
    endcase
	end
endmodule
