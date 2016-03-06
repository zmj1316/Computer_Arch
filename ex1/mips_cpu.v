`include "define.vh"

module mips_core (
	input wire clk,  // main clock
	input wire rst,  // reset
	// debug
	`ifdef DEBUG
	input wire debug_en,  // enable
	input wire debug_step,  // clock
	input wire [6:0] debug_addr,  // address
	output wire [31:0] debug_data,  // data
	`endif
	);
	
	// Global
	reg [31:0] PC;
	// Control
	reg [31:0] inst;
	reg [31:0] RS_data;
	reg [31:0] RT_data;

	wire [1:0] PC_src;
	wire imme_sign_ext;
	wire [1:0] A_src;
	wire [1:0] B_src;
	wire [3:0] ALU_op;
	wire ALU_sign_ext;

	wire [1:0] mem_size;
	wire memread;
	wire memwrite;

	wire wb;
	wire [1:0] wb_src;
	wire [1:0] wb_dst;
	
	// IF signal
	wire [31:0] PC_next;
	// 


	// debug
	// reg [31:0] debug_data_signal;
	// always @(posedge clk) begin
	// 	case (debug_addr[4:0])
	// 		0: debug_data_signal <= inst_addr;
	// 		1: debug_data_signal <= inst_data;
	// 		2: debug_data_signal <= inst_addr_id;
	// 		3: debug_data_signal <= inst_data_ctrl;
	// 		4: debug_data_signal <= inst_addr_exe;
	// 		5: debug_data_signal <= inst_data_exe;
	// 		6: debug_data_signal <= inst_addr_mem;
	// 		7: debug_data_signal <= inst_data_mem;
	// 		8: debug_data_signal <= {19'b0, inst_ren, 7'b0, mem_ren, 3'b0, mem_wen};
	// 		9: debug_data_signal <= mem_addr;
	// 		10: debug_data_signal <= mem_din;
	// 		11: debug_data_signal <= mem_dout;
	// 		default: debug_data_signal <= 32'hFFFF_FFFF;
	// 	endcase
	// end

	ALU alu(
		.A(),
		.B(),
		.sign_ext(),
		.opcode(),
		.res()
		);
	regfile RF(
		.clk(),
		.outa(),
		.outb(),
		.write(),
		`ifdef DEBUG
		.debug_addr(),
		.debug_data(),
		`endif
		);
	Ctrl CU(
		.clk(),
		.inst(),
		.RS_data(),
		.RT_data(),
		.PC_src(),
		.A_src(),
		.B_src(),
		.ALU_op(),
		.sign_ext(),
		.imme_sign_ext(),
		.memread(),
		.memwrite(),
		.mem_size(),
		.wb(),
		.wb_src(),
		.wb_dst()
		);

	always @(posedge clk) begin

	end
endmodule
