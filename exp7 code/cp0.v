
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

	,
	output wire irout
	);
	
	`include "mips_define.vh"

	// interrupt determination
	wire ir;
	reg ir_wait = 0, ir_valid = 1;
	assign irout = ir_valid;
	reg eret = 0;
	wire [31:0] epc;
	wire [31:0] ehbr;
	
	reg [31:0] cpr[31:0];
	
	assign epc = cpr[2];
	assign ehbr = cpr[1];
	
	integer i;
	
	initial begin
		for (i=0; i<32; i = i+1)
			cpr[i] = 32'b0;
	end
	
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
		if(ir)begin
			cpr[2] <= ret_addr;

		end
		else begin
			case (oper)
				EXE_CP_NONE: begin
					data_r <= cpr[addr_r];
				end
				EXE_CP_STORE:begin
					cpr[addr_w] <= data_w;
					// jump_en <= 0;
				end
				EXE_CP0_ERET:begin
					jump_addr = cpr[2];
				end
			endcase
		end
	end	
	
	// jump determination

	always @(*) begin
		jump_en = 0;
		if (ir) begin
			jump_addr = ehbr;
			jump_en = 1;
			eret = 0;
		end else
		if (oper == EXE_CP0_ERET) begin
			jump_addr = epc;
			jump_en = 1;
			eret = 1;
		end else 
			eret =0;
	end

endmodule
