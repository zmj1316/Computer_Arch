`timescale 1ns / 1ps
`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:54:37 05/19/2015 
// Design Name: 
// Module Name:    top 
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
module mips(
	input clk,
	input rst,
	`ifdef DEBUG
	input debug_en,
	input debug_step,
	input [6:0] debug_addr,
	output [31:0] debug_data,
	`endif
	input interrupter
);
reg [31:0] PC;
wire [31:0] inst;
wire [31:0] imout;
wire [11:0]  btn_out;

wire [31:0] regtest;


wire RegDst;
wire ALUsrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch;
wire [1:0] ALUop;
wire Jump;
wire zero;
wire [31:0] ALUout;
wire [31:0] Memout;

wire [31:0]wrdata;
assign wrdata=MemtoReg?Memout:ALUout;
wire [31:0]Rdata1;
wire [31:0]Rdata2;

wire [31:0] PC_1;
assign PC_1=PC+4;	

wire [31:0] PC_2;
assign PC_2 = PC_1+{{14{inst[15]}},inst[15:0],2'b00};

wire [31:0] PC_3;
assign PC_3 = (Branch&zero)?PC_2:PC_1;

wire [31:0] PC_next;

reg [15:0]dis;
reg [31:0]dis32;

assign PC_next = Jump?{PC[31:28],inst[25:0],2'b00}:PC_3;
ALU a(Rdata1,ALUsrc?{{16{inst[15]}},inst[15:0]}:Rdata2,inst[5:0],ALUop,zero,ALUout);
// regfile RF(btn_in[0],inst[25:21],inst[20:16],RegDst?inst[15:11]:inst[20:16],wrdata,RegWrite,Rdata1,Rdata2);
regfile RF(btn_out[0],inst[25:21],inst[20:16],RegDst?inst[15:11]:inst[20:16],wrdata,RegWrite,Rdata1,Rdata2,debug_addr,debug_data);
// regfile RF(clk,switch[6:2],switch[6:2],switch[6:2],wrdata,1'b0,Rdata1,Rdata2);

myram dm(.clka(clk),
		   .addra(ALUout),
		   .dina(Rdata2),
		   .wea(MemWrite),
		   .douta(Memout));
instmem im(.addra(PC[5:2]),
		   .clka(clk),
		   .douta(inst));
CtrlUe CU(inst,RegDst,ALUsrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop,Jump);

initial begin
PC = 0;
end
`ifdef DEBUG
always @(posedge debug_step) begin
	PC=PC_next;
end
`else 
always @(posedge clk) begin
	PC=PC_next;
end
`endif

endmodule
