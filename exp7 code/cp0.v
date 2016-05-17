
`include "define.vh"

module cp0 (
	input wire clk,  // main clock
	// debug
	// operations (read in ID stage and write in EXE stage)
	input wire [1:0] oper,  // CP0 operation type
	input wire [4:0] addr_r,  // read address
	output reg [31:0] data_r,  // read data
	input wire [4:0] addr_w,  // write address
	input wire [31:0] data_w,  // write data
	// exceptions (check exceptions in MEM stage)
	input wire rst,  // synchronous reset
	input wire ir_en,  // interrupt enable
	input wire ir_in,  // external interrupt input
	input wire [31:0] ret_addr,  // target instruction address to store when interrupt occurred
	output reg jump_en,  // force jump enable signal when interrupt authorised or ERET occurred
	output reg [31:0] jump_addr  // target instruction address to jump to
	);
	
	`include "mips_define.vh"

	// interrupt determination
	wire ir;
	reg ir_wait = 0, ir_valid = 1;
	reg eret = 0;
	reg [31:0] epc;
	
	reg [31:0] cpr[0:31];
	
	always @(posedge clk) begin
		if (rst)
			ir_wait <= 0;
		else if (ir_in)
			ir_wait <= 1;
		else if (eret)
			ir_wait <= 0;
	end
	
	always @(posedge clk) begin
		if (rst)
			ir_valid <= 1;
		else if (eret)
			ir_valid <= 1;
		else if (ir)
			ir_valid <= 0;  // prevent exception reenter
	end
	
	assign ir = ir_en & ir_wait & ir_valid;

	// Exception Handler Base Register
	always @(posedge clk) begin
		eret <= 0;
		case (oper)
			EXE_CP_NONE: 
				data_r <= cpr[addr_r];
			EXE_CP_STORE:
				cpr[addr_w] <= data_w;
			EXE_CP0_ERET: eret <= 1;		
		endcase
	end

	// Exception Program Counter Register
	always @(posedge clk) begin
		if (ir) begin
			epc <= ret_addr;
		end
	end
	
	// jump determination
	always @(posedge clk) begin
		jump_en <= 0;
		if (eret) begin
			jump_en <= 1;
			jump_addr <= epc;
		end
	end

endmodule
