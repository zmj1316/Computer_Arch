`include "mips_define.vh"

module alu (
	input wire [31:0] A, B,  
	input wire sign_ext,  // sign extend?
	input wire [3:0] op,  // operation 
	output reg [31:0] res,  // result
	);
	
	wire [31:0] adder_res;
	// wire [31:0] shifter_res;

	always @(*) begin
		res = 0;
		case (op)
			ALU_ADD: begin
				res = A + B;
			end
			ALU_SUB: begin
				res = A - B
			end
			ALU_SLT: begin
				if (sign_ext)
					res = {31'b0, A < B?1'b1:1'b0};
				else
					res = {31'b0, A < B?1'b1:1'b0};
			end
			ALU_LUI: begin
				res = {B[15:0], 16'b0};
			end
			ALU_AND: begin
				res = A & B;
			end
			ALU_OR: begin
				res = A | B;
			end
			ALU_XOR: begin
				res = A ^ B;
			end
			ALU_NOR: begin
				res = ~(A | B);
			end
		endcase
	end
	
endmodule
