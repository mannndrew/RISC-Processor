module alu
(
	input [31:0] I_operandA,
	input [31:0] I_operandB,
	input [3:0] I_aluop,
	output reg [31:0] O_result
);

wire [31:0] result_add = I_operandA + I_operandB;
wire [32:0] result_sub = {1'b0, I_operandA} - {1'b0, I_operandB};
wire [31:0] result_and = I_operandA & I_operandB;
wire [31:0] result_or = I_operandA | I_operandB;
wire [31:0] result_xor = I_operandA ^ I_operandB;
wire [31:0] result_slt = {{31{1'b0}}, result_sub[32] ^ result_xor[31]};
wire [31:0] result_sltu = {{31{1'b0}}, result_sub[32]};
wire [31:0] result_sll = I_operandA << I_operandB[4:0];
wire [31:0] result_srl = I_operandA >> I_operandB[4:0];
wire [31:0] result_sra = $signed(I_operandA) >>> I_operandB[4:0];

always @(*) begin
	case (I_aluop)
		4'b0000: O_result = result_add[31:0];
		4'b0001: O_result = result_sub[31:0];
		4'b0010: O_result = result_and[31:0];
		4'b0011: O_result = result_or[31:0];
		4'b0100: O_result = result_xor[31:0];
		4'b0101: O_result = result_slt[31:0];
		4'b0110: O_result = result_sltu[31:0];
		4'b0111: O_result = result_sll[31:0];
		4'b1000: O_result = result_srl[31:0];
		4'b1001: O_result = result_sra[31:0];
		default: O_result = 32'd0;
	endcase
end

endmodule

