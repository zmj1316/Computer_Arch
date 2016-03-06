`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:22:12 06/02/2015
// Design Name:   ALU
// Module Name:   F:/Workspace/Computer-Organization/SingleClk/ALU_T.v
// Project Name:  SingleClk
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_T;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [5:0] func;
	reg [1:0] ALUop;

	// Outputs
	wire zero;
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.A(A), 
		.B(B), 
		.func(func), 
		.ALUop(ALUop), 
		.zero(zero), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		A = 32'h12345678;
		B = 32'h00001111;
		func = 6'b100000;
		ALUop = 2'b10;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

