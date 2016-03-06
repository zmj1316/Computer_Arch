`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:28:42 06/02/2015
// Design Name:   top
// Module Name:   F:/Workspace/Computer-Organization/SingleClk/toptest.v
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

module toptest;

	// Inputs
	reg clk;
	reg [13:0] switch;
	reg [11:0] btn_in;

	// Outputs
	wire [11:0] anode;
	wire [15:0] segment;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.anode(anode), 
		.segment(segment), 
		.switch(switch), 
		.btn_in(btn_in)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		switch = 0;
		btn_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
      switch[1]=1;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		btn_in[0]=1;
		#100;
		btn_in[0]=0;
		#100;
		// Add stimulus here

	end
   initial forever begin 
		clk=~clk;
		#5;
	end
endmodule

