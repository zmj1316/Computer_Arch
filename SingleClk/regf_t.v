`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:32:00 06/02/2015
// Design Name:   regfile
// Module Name:   F:/Workspace/Computer-Organization/SingleClk/regf_t.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regfile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regf_t;

	// Inputs
	reg clk;
	reg [4:0] r1;
	reg [4:0] r2;
	reg [4:0] wr;
	reg [31:0] wdata;
	reg regw;

	// Outputs
	wire [31:0] o1;
	wire [31:0] o2;

	// Instantiate the Unit Under Test (UUT)
	regfile uut (
		.clk(clk), 
		.r1(r1), 
		.r2(r2), 
		.wr(wr), 
		.wdata(wdata), 
		.regw(regw), 
		.o1(o1), 
		.o2(o2)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		r1 = 1;
		r2 = 1;
		wr = 1;
		wdata = 32'h0000fff0;
		regw = 0;

		// Wait 100 ns for global reset to finish
		#100;
		 regw=1;
		 #10;
		 regw=0;
		 r2=2;
		// Add stimulus here

	end
      initial forever begin
			clk=~clk;
			#5;
			end
endmodule

