module pccounter
(
	input clk,
	input rst,
	input [31:0] pc_in,
	output [31:0] pc_next,
	output reg [31:0] pc_out
);

assign pc_next = {pc_out[31:2] + 30'b1, {2{1'b0}}};

always @(posedge clk, negedge rst) begin
	if (rst == 1'b0)
		pc_out <= 32'd0;
	else
		pc_out <= pc_in;
end


endmodule
