`include "mips_define.vh"

module Ctrl(
	input wire clk,
	input wire [31:0] inst,
	input wire [31:0] RS_data,
	input wire [31:0] RT_data,
	output reg [1:0] PC_src,
	output reg [1:0] A_src,
	output reg [1:0] B_src,
	output reg [1:0] ALU_op,
	output reg sign_ext,
	output reg imme_sign_ext,
	output reg memread,
	output reg memwrite,
	output reg [1:0] mem_size,
	output reg wb,
	output reg [1:0] wb_src,	
	output reg [1:0] wb_dst
	);
	
	always @(* or posedge rst) begin
		PC_src = PC_N;
		A_src = ALU_A_RS;
		B_src = ALU_B_IMM;	// Notice !! default for I-type
		ALU_op = ALU_ADD;
		sign_ext = 0;
		imme_sign_ext = 0;	// Notice !!
		memwrite = 0;
		memread = 0;
		mem_size = 0;
		wb = 1;
		wb_src = WB_SRC_ALU;
		wb_dst = WB_DST_RT;	// Notice !!
		case (inst[31:26])
			Rtype: begin
				// wb = 1;
				// imme_sign_ext = 0;
				B_src = ALU_B_RT;
				wb_dst = WB_DST_RD;	// Notice !!
				case (inst[5:0])
					R_add: begin
						ALU_op = ALU_ADD;
						sign_ext = 1;
					end
					R_addu: begin
						ALU_op = ALU_ADD;
						// sign_ext = 0;
					end
					R_sub: begin
						ALU_op = ALU_SUB;
						sign_ext = 1;
					end
					R_subu: begin
						ALU_op = ALU_SUB;
						// sign_ext = 0;
					end
					R_and: begin
						ALU_op = ALU_AND;
					end
					R_or: begin
						ALU_op = ALU_OR;
					end
					R_xor: begin
						ALU_op = ALU_XOR;
					end
					R_nor: begin
						ALU_op = ALU_NOR;
					end
					R_slt: begin
						ALU_op = ALU_SLT;
						sign_ext = 1;
					end
					R_sltu: begin
						ALU_op = ALU_SLT;
						// sign_ext = 0;
					end
					R_sll: begin
						A_src = ALU_A_S;
						ALU_op = ALU_SLL;
					end
					R_srl: begin
						A_src = ALU_A_S;
						ALU_op = ALU_SRL;
					end
					// TODO: fill other shift ops
					R_jr: begin
						wb = 0;
						PC_src = PC_JR;
					end
					default:begin
						
					end
				endcase
			end
			I_addi: begin
				ALU_op = ALU_ADD;
				sign_ext = 1;
				// B_src = ALU_B_IMM;
				imme_sign_ext = 1;
				// wb_dst = WB_DST_RT;
			end
			I_addiu: begin
				ALU_op = ALU_ADD;
				// imme_sign_ext = 0;
			end
			I_slti: begin
				imme_sign_ext = 1;
				ALU_op = ALU_SLT;
				sign_ext = 1;
				imme_sign_ext = 1;
			end
			I_sltiu: begin
				// imme_sign_ext = 0;
				ALU_op = ALU_SLT;
				sign_ext = 1;
				imme_sign_ext = 1;
			end
			I_andi: begin
				// imme_sign_ext = 0;
				ALU_op = ALU_AND;
			end
			I_ori: begin
				ALU_op = ALU_OR;
			end
			I_xori: begin
				ALU_op = ALU_XOR;
			end
			I_lui: begin
				ALU_op = ALU_LUI;
			end
			I_lw: begin
				// ALU_op = ALU_ADD;
				imme_sign_ext = 1;
				mem_size = MEM_WORD;
				memread = 1;
				wb_src = WB_SRC_MEM;
			end
			I_sw: begin
				imme_sign_ext = 1;
				mem_size = MEM_WORD;
				memwrite = 1;
				wb = 0;
			end
			I_CP: begin

				case(inst[25:21])
					CP_MFC:
					CP_MTC:
					CP_eret:
				endcase
			end
			// TODO:
			I_beq: begin
				wb = 0;
				imme_sign_ext = 1;
				PC_src = PC_B;
			end
			I_bne: begin
				wb = 0;
				imme_sign_ext = 1;
				PC_src = PC_B;
			end
			I_j: begin
				wb = 0;
				PC_src = PC_J;
			end
			I_jal: begin
				PC_src = PC_J;
				A_src = ALU_A_L;
				B_src = ALU_B_L;
				wb_src = WB_SRC_L;
				wb_dst = WB_DST_L;
			end
		endcase
	end



endmodule