module regfile
(
	input clk,
	input [4:0] write_address,
	input [4:0] read_address_1,
	input [4:0] read_address_2,
	input [31:0] write_data,
	output [31:0] read_data_1,
	output [31:0] read_data_2
	
);

reg [31:0] register_block [31:1];

// Write Port

always @(posedge clk) begin
	if (write_address != 5'd0)
		register_block[write_address] <= write_data;
end

// Read Port 1
assign read_data_1 = (read_address_1 == 5'd0) ? 32'd0 : register_block[read_address_1];

// Read Port 2
assign read_data_2 = (read_address_2 == 5'd0) ? 32'd0 : register_block[read_address_2];



endmodule
