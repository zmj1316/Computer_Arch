`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:38:58 06/02/2015
// Design Name:   top
// Module Name:   F:/Workspace/Computer-Organization/SingleClk/top_t0.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_t0;

	// Inputs
	reg clk;
	reg [13:0] switch;
	reg [11:0] btn_in;

	// Outputs
	wire [11:0] anode;
	wire [15:0] segment;
	wire [4:0] led;
	wire [31:0] Rdata2;
	wire [31:0] Rdata1;
	wire [31:0] inst;
	wire [31:0] PC;
	wire [31:0] ALUout;
	wire [31:0] wrdata;
	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.anode(anode), 
		.segment(segment), 
		.switch(switch), 
		.btn_in(btn_in), 
		.led(led), 
		.Rdata2(Rdata2), 
		.Rdata1(Rdata1),
		.inst(inst),
		.PC(PC),
		.ALUout(ALUout),
		.wrdata(wrdata)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		switch = 0;
		btn_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		switch[1]=1;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		btn_in[0]=1;
	end
     initial forever begin
	  clk=~clk;
	  #1;
	  end
endmodule

