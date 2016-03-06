`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:00:43 03/24/2015 
// Design Name: 
// Module Name:    adder 
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

module adder_1bit(a, b, ci, s, co);
	// port declaration
	input wire a,b,ci;
	output wire s,co;
	and (c1,a,b), (c2,b,ci), (c3,a,ci);
	xor (s1,a,b), (s,s1,ci);
	or (co,c1,c2,c3);
endmodule


module add_4 ( input [3:0]a, input [3:0]b, input cin, output [3:0] s, output co );/*4位并*/
wire [3:0]c_tmp;  
wire [3:0]g;  
wire [3:0]p; 
assign co = c_tmp[3]; 
assign  g[0] = a[0] & b[0], g[1] = a[1] & b[1], g[2] = a[2] & b[2], g[3] = a[3] & b[3]; 
assign  p[0] = a[0] | b[0], p[1] = a[1] | b[1], p[2] = a[2] | b[2], p[3] = a[3] | b[3];  
assign   c_tmp[0] = g[0] | ( p[0] & cin ),
   c_tmp[1] = g[1] | ( p[1] & g[0]) | ( p[1] & p[0] & cin),
   c_tmp[2] = g[2] | ( p[2] & g[1]) | ( p[2] & p[1] & g[0]) | ( p[2] & p[1] & p[0] & cin),
   c_tmp[3] = g[3] | ( p[3] & g[2]) | ( p[3] & p[2] & g[1]) | ( p[3] & p[2] & p[1] & g[0]) | ( p[3] & p[2] & p[1] & p[0] & cin);  
assign s[3:0] = a[3:0] ^ b[3:0] ^{c_tmp[2:0],cin}; 
endmodule





// module adder_32bit(A, B, Ctr, S,CF,OF,ZF,PF,slt,sltu);/*4位并*/
//     	parameter size=32;
//   input [size:1] A;
//   input [size:1] B;
//   input Ctr;
//   output [size:1] S;
//   wire Co;
//   output CF,OF,ZF,PF;
//   output slt,sltu;
// 	wire[7:1]  Ctemp;
// 	wire[size:1]    Bo;
//   assign Bo={32{Ctr}}^B;

//   add_4 A1(A[4:1],Bo[4:1],Ctr,S[4:1],Ctemp[1]),
//         A2(A[8:5],Bo[8:5],Ctemp[1],S[8:5],Ctemp[2]),
//         A3(A[12:9],Bo[12:9],Ctemp[2],S[12:9],Ctemp[3]),
//         A4(A[16:13],Bo[16:13],Ctemp[3],S[16:13],Ctemp[4]),
//         A5(A[20:17],Bo[20:17],Ctemp[4],S[20:17],Ctemp[5]),
//         A6(A[24:21],Bo[24:21],Ctemp[5],S[24:21],Ctemp[6]),
//         A7(A[28:25],Bo[28:25],Ctemp[6],S[28:25],Ctemp[7]),
//         A8(A[32:29],Bo[32:29],Ctemp[7],S[32:29],Co);


// 	assign CF=Ctr^Co;
//     assign OF=Co^Ctemp[7];
//     assign SF=S[32];
//     assign ZF=~(S[1]|S[2]|S[3]|S[4]|S[5]|S[6]|S[7]|S[8]|S[9]|S[10]|S[11]|S[12]|S[13]|S[14]|S[15]
// |S[16]|S[17]|S[18]|S[19]|S[20]|S[21]|S[22]|S[23]|S[24]|S[25]|S[26]|S[27]|S[28]|S
// [29]|S[30]|S[31]|S[32]);
//     assign PF=S[1]^S[2]^S[3]^S[4]^S[5]^S[6]^S[7]^S[8]^S[9]^S[10]^S[11]^S[12]^S[13]^S[14]^S[15]
// ^S[16]^S[17]^S[18]^S[19]^S[20]^S[21]^S[22]^S[23]^S[24]^S[25]^S[26]^S[27]^S[28]^S
// [29]^S[30]^S[31]^S[32];
//   assign slt=OF^S[32];
//   assign sltu=CF;


// endmodule




module adder_32bit(A, B, Ctr, S,CF,OF,ZF,PF,slt,sltu);/*串*/
      parameter size=32;
  input [size:1] A;
  input [size:1] B;
  input Ctr;
  output [size:1] S;
  wire Co;
  output CF,OF,ZF,PF;
  wire[size-1:1]  Ctemp;
  wire[size:1]    Bo;
  assign Bo={32{Ctr}}^B;
  output slt,sltu;
adder_1bit   A1(.a(A[1]),.b(Bo[1]),.ci(Ctr),.s(S[1]),.co(Ctemp[1])),
      
A2(A[2],Bo[2],Ctemp[1],S[2],Ctemp[2]),
A3(A[3],Bo[3],Ctemp[2],S[3],Ctemp[3]),
A4(A[4],Bo[4],Ctemp[3],S[4],Ctemp[4]),
A5(A[5],Bo[5],Ctemp[4],S[5],Ctemp[5]),
A6(A[6],Bo[6],Ctemp[5],S[6],Ctemp[6]),
A7(A[7],Bo[7],Ctemp[6],S[7],Ctemp[7]),
A8(A[8],Bo[8],Ctemp[7],S[8],Ctemp[8]),
A9(A[9],Bo[9],Ctemp[8],S[9],Ctemp[9]),
A10(A[10],Bo[10],Ctemp[9],S[10],Ctemp[10]),
A11(A[11],Bo[11],Ctemp[10],S[11],Ctemp[11]),
A12(A[12],Bo[12],Ctemp[11],S[12],Ctemp[12]),
A13(A[13],Bo[13],Ctemp[12],S[13],Ctemp[13]),
A14(A[14],Bo[14],Ctemp[13],S[14],Ctemp[14]),
A15(A[15],Bo[15],Ctemp[14],S[15],Ctemp[15]),
A16(A[16],Bo[16],Ctemp[15],S[16],Ctemp[16]),
A17(A[17],Bo[17],Ctemp[16],S[17],Ctemp[17]),
A18(A[18],Bo[18],Ctemp[17],S[18],Ctemp[18]),
A19(A[19],Bo[19],Ctemp[18],S[19],Ctemp[19]),
A20(A[20],Bo[20],Ctemp[19],S[20],Ctemp[20]),
A21(A[21],Bo[21],Ctemp[20],S[21],Ctemp[21]),
A22(A[22],Bo[22],Ctemp[21],S[22],Ctemp[22]),
A23(A[23],Bo[23],Ctemp[22],S[23],Ctemp[23]),
A24(A[24],Bo[24],Ctemp[23],S[24],Ctemp[24]),
A25(A[25],Bo[25],Ctemp[24],S[25],Ctemp[25]),
A26(A[26],Bo[26],Ctemp[25],S[26],Ctemp[26]),
A27(A[27],Bo[27],Ctemp[26],S[27],Ctemp[27]),
A28(A[28],Bo[28],Ctemp[27],S[28],Ctemp[28]),
A29(A[29],Bo[29],Ctemp[28],S[29],Ctemp[29]),
A30(A[30],Bo[30],Ctemp[29],S[30],Ctemp[30]),
A31(A[31],Bo[31],Ctemp[30],S[31],Ctemp[31]),
A32(A[32],Bo[32],Ctemp[31],S[32],Co);
            
            
  assign CF=Ctr^Co;
    assign OF=Co^Ctemp[31];
    assign SF=S[32];
    assign ZF=~(S[1]|S[2]|S[3]|S[4]|S[5]|S[6]|S[7]|S[8]|S[9]|S[10]|S[11]|S[12]|S[13]|S[14]|S[15]
|S[16]|S[17]|S[18]|S[19]|S[20]|S[21]|S[22]|S[23]|S[24]|S[25]|S[26]|S[27]|S[28]|S
[29]|S[30]|S[31]|S[32]);
    assign PF=S[1]^S[2]^S[3]^S[4]^S[5]^S[6]^S[7]^S[8]^S[9]^S[10]^S[11]^S[12]^S[13]^S[14]^S[15]
^S[16]^S[17]^S[18]^S[19]^S[20]^S[21]^S[22]^S[23]^S[24]^S[25]^S[26]^S[27]^S[28]^S
[29]^S[30]^S[31]^S[32];
  assign slt=OF^S[32];
  assign sltu=CF;


endmodule