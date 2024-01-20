module pccounter
(
	input clk,
	input rst,
	output [31:0] pc_address
);

reg [29:0] pc_reg;

always @(posedge clk, negedge rst) begin
	if (rst == 1'b0)
		pc_reg <= 30'd0;
	else
		pc_reg <= pc_reg + 30'd1;
end

assign pc_address = {pc_reg, 2'b00};

endmodule
