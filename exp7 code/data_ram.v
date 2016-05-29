module data_ram (
	input wire clk,
	input wire rst,
	input wire cs,
	input wire we,
	input wire [31:0] addr,
	input wire [31:0] din,
	output reg [31:0] dout,
	output reg stall
	);
	
	parameter
		ADDR_WIDTH = 5;
	reg [2:0] state = 0;
	reg [31:0] data [0:(1<<ADDR_WIDTH)-1];
	wire ACK;
	assign ACK = state == 3'b111;
	initial	begin
		$readmemh("data_mem.hex", data);
	end
	
	always @(negedge clk) begin
		if (cs) begin
			state <= state + 1;
		end
		else begin
			state <= 0;
		end
		if (we && addr[31:ADDR_WIDTH]==0 && ACK)
			data[addr[ADDR_WIDTH-1:0]] <= din;
	end
	
	reg [31:0] out;
	always @(negedge clk) begin
		out <= data[addr[ADDR_WIDTH-1:0]];
	end
	
	always @(*) begin
		if (addr[31:ADDR_WIDTH] != 0 || ~ACK)
			dout = 32'h0;
		else
			dout = out;
		stall = cs & ~ACK;
	end
	
endmodule
