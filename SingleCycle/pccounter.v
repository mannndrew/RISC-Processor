module pccounter
(
	input clk,
	input rst,
	input [31:0] pc_in,
	output reg [31:0] pc_out
);

always @(posedge clk, negedge rst) begin
	if (rst == 1'b0)
		pc_out <= 32'd0;
	else
		pc_out <= {pc_out[31:2] + pc_in[31:2], {2{1'b0}}};
end


endmodule
