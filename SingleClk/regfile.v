`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:50:49 05/26/2015 
// Design Name: 
// Module Name:    regfile 
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
module regfile(input clk,input [4:0]r1,input [4:0]r2,input[4:0]wr,input[31:0]wdata,input wire regw,output wire [31:0]o1,output wire [31:0]o2
    ,input [4:0]testaddr,output [31:0]testreg);
reg [31:0] data [31:0];
assign o1 = data[r1];
assign o2 = data[r2];
assign testreg = data[testaddr];
integer i;

initial begin 
	for(i=0;i<32;i=i+1)
	begin 
		data[i]=i;
	end
end


always @(negedge clk) begin
	if (regw)begin
		data[wr]<=wdata;
	end
end

endmodule
