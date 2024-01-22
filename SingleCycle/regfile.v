module regfile
(
	input clk,
	input [4:0] write_addr,
	input [31:0] write_data,
	input [4:0] read_addr_1,
	input [4:0] read_addr_2,
	output [31:0] read_data_1,
	output [31:0] read_data_2,
	output [31:0] reg1_data
);

reg [31:0] register_block [31:1];

// Write Port

always @(posedge clk) begin
	if (write_addr != 5'd0)
		register_block[write_addr] <= write_data;
end

// Read Port 1
assign read_data_1 = (read_addr_1 == 5'd0) ? 32'd0 : register_block[read_addr_1];

// Read Port 2
assign read_data_2 = (read_addr_2 == 5'd0) ? 32'd0 : register_block[read_addr_2];



assign reg1_data = register_block[1];



endmodule
