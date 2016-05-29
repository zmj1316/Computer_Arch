module inst_rom (
	input wire clk,
	input wire rst,
	input wire cs,
	input wire [31:0] addr,
	output reg [31:0] dout,
	output reg stall
	);
	
	parameter
		ADDR_WIDTH = 6;
	
	reg [31:0] data [0:(1<<ADDR_WIDTH)-1];
	reg [2:0] state = 0;
	initial	begin
		$readmemh("inst_mem.hex", data);
	end
	
	reg [31:0] out;
	wire ACK;
	assign ACK = state == 3'b111;
	always @(negedge clk) begin
		if (cs) begin
			state <= state + 1;		
		end	
		else begin
			state <= 0;
		end
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
