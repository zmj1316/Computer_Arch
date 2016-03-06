`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:47 05/26/2015 
// Design Name: 
// Module Name:    myram 
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
module myram(input clka,input [31:0]addra,input [31:0]dina,input wea,output reg[31:0]douta
    );


wire clk;
assign clk = clka;
reg[31:0]addr;
reg[31:0]datain;
reg[63:0]tem;

wire [31:0]dout;

reg[1:0] st;
reg we;
datamem ram(
	.clka(clk),
	.wea(we),
	.addra(addr),
	.dina(datain),
	.douta(dout)
);
initial begin
st=0;
we=0;
end

always@(posedge clk)begin
st=st+1;
end


always@(posedge clk)
begin
	we=0;
	case (st[0])
		0:begin 
			addr = addra[31:2];
			tem[31:0]=dout;
			end	
		1:begin 
			addr = addra[31:2]+1;
			tem[63:32]=dout;
			end
	endcase
	if (wea) begin
		case(addra[1:0])
			0:datain=st[0]?tem[63:32]:dina[31:0];
			1:datain=st[0]?{tem[63:40],dina[31:24]}:{dina[23:0],tem[7:0]};
			2:datain=st[0]?{tem[63:48],dina[31:16]}:{dina[15:0],tem[15:0]};
			3:datain=st[0]?{tem[63:56],dina[31:8]}:{dina[7:0],tem[23:0]};
		endcase
		we=1;
	end
end
always@*
begin


	case(addra[1:0])
		0:douta=tem[31:0];
		1:douta=tem[39:8];
		2:douta=tem[47:16];
		3:douta=tem[55:24];
	endcase
end





endmodule
