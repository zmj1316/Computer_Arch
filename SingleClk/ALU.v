`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:54:48 05/19/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU(input [31:0] A,input[31:0] B,input [5:0] func,input [1:0]ALUop,output zero,output reg[31:0] out
    );

assign zero=~(out[0]|out[1]|out[2]|out[3]|out[4]|out[5]|out[6]|out[7]|out[8]|out[9]|out[10]|out[11]|out[12]|out[13]|out[14]|out[15]|out[16]|out[17]|out[18]|out[19]|out[20]|out[21]|out[22]|out[23]|out[24]|out[25]|out[26]|out[27]|out[28]|out[29]|out[30]|out[31]
);
wire Ctr,CF,OF,ZF,PF,slt,sltu;
wire[31:0]S;
adder_32bit adder(A, B, 1'b1, S,CF,OF,ZF,PF,slt,sltu);
always @(*) begin
	case(ALUop)
		2'b00:out <= A+B;
		2'b01:out <= A-B;
		2'b10:begin
				case(func)
					6'h20:out<=A+B;
					6'h21:out<=A+B;
					6'h24:out<={32{A}}&{32{B}};
					6'h2a:out<={0,slt};
					6'h2b:out<={0,sltu};
				endcase
			end
	endcase
end


endmodule
