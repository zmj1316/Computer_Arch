`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:01:47 05/26/2015 
// Design Name: 
// Module Name:    CtrlU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CtrlUe(input [31:0] inst,output  RegDst,output  ALUsrc,output MemtoReg,output RegWrite,output  MemRead,output  MemWrite,output  Branch,output  [1:0] ALUop,output  Jump
    );
	assign Jump=(inst[31:26]==6'b000010)?1'b1:1'b0;
	// assign RegDst = (inst[31:26]==6'b0)?1:0;
	// assign ALUsrc = (inst[31:26]==6'b100011|inst[31:26]==6'b101011)?1:0;
	// assign MemtoReg = (inst[31:26]==6'b100011)?1:0;
	assign RegWrite = (inst[30:28]==3'b000)?1:0;
	wire [5:0]OP;
	assign OP = inst[31:26];

	and (RegDst, ~OP[5],~OP[4],~OP[3],~OP[2],~OP[1],~OP[0]);
	and (ALUsrc, OP[5],~OP[4], ~OP[2], OP[1], OP[0]);
	and (MemtoReg, OP[5],~OP[4],~OP[3],~OP[2], OP[1], OP[0]);
	//and (RegWrite, ~OP[4],~OP[3],~OP[2],~OP[1] );
	and (MemRead, OP[5],~OP[4],~OP[3],~OP[2], OP[1], OP[0]);
	and (MemWrite, OP[5],~OP[4], OP[3],~OP[2], OP[1], OP[0]);
	and (Branch, ~OP[5],~OP[4],~OP[3], OP[2],~OP[1],~OP[0]);
	and (ALUop[1], ~OP[5],~OP[4],~OP[3],~OP[2],~OP[1],~OP[0]);
	and (ALUop[0], ~OP[5],~OP[4],~OP[3], OP[2],~OP[1],~OP[0]);

endmodule
