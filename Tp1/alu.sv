//ALU

module alu #(parameter N = 64) 
				(input logic [N-1:0] a,b,
				input logic [3:0] ALUControl,
				output logic [N-1:0] result,
				output logic zero);

logic [N-1:0] res;

always_comb begin
	case (ALUControl)
		4'b0000: res = a & b;      // AND lógico
		4'b0001: res = a | b;      // OR lógico
		4'b0010: res = a + b;      // Suma
      4'b0110: res = a - b;      // Resta
      4'b0111: res = b;          // Pasar b
      default: res = 64'b0;      // Valor por defecto (opcional)
	endcase
end

assign result = res;

assign zero = (result == 64'b0) ? 1'b1 : 1'b0;

endmodule
					