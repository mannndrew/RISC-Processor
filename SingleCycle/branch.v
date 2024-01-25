module branch
(
	input [31:0] dataS1,
	input [31:0] dataS2,
	input [3:0] branchop,
	output branch
);

wire [2:0] op = branchop[2:0];
wire branch_instruction = branchop[3];
reg branch_result;

always @(*) begin
	case(op)
		3'b000: branch_result = (dataS1 == dataS2);
		3'b001: branch_result = (dataS1 != dataS2);
		3'b010: branch_result = ($signed(dataS1) < $signed(dataS2));
		3'b011: branch_result = (dataS1 < dataS2);
		3'b100: branch_result = ($signed(dataS1) >= $signed(dataS2));
		3'b101: branch_result = (dataS1 >= dataS2);
		default: branch_result = 1'b0;
	endcase
end

assign branch = branch_result & branch_instruction;

endmodule
