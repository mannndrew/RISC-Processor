module alu
(
	input [31:0] dataS1,
	input [31:0] dataS2,
	input [3:0] aluop,
	output reg [31:0] result
);

wire [31:0] result_add = dataS1 + dataS2;
wire [32:0] result_sub = {1'b0, dataS1} - {1'b0, dataS2};
wire [31:0] result_and = dataS1 & dataS2;
wire [31:0] result_or = dataS1 | dataS2;
wire [31:0] result_xor = dataS1 ^ dataS2;
wire [31:0] result_slt = {{31{1'b0}}, result_sub[32] ^ result_xor[31]};
wire [31:0] result_sltu = {{31{1'b0}}, result_sub[32]};
wire [31:0] result_sll = dataS1 << dataS2[4:0];
wire [31:0] result_srl = dataS1 >> dataS2[4:0];
wire [31:0] result_sra = $signed(dataS1) >>> dataS2[4:0];

always @(*) begin
	case (aluop)
		4'b0000: result = result_add[31:0];
		4'b0001: result = result_sub[31:0];
		4'b0010: result = result_and[31:0];
		4'b0011: result = result_or[31:0];
		4'b0100: result = result_xor[31:0];
		4'b0101: result = result_slt[31:0];
		4'b0110: result = result_sltu[31:0];
		4'b0111: result = result_sll[31:0];
		4'b1000: result = result_srl[31:0];
		4'b1001: result = result_sra[31:0];
		default: result = 32'd0;
	endcase
end

endmodule

