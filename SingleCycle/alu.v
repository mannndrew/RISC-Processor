module alu
(
    input [31:0] operand_a,
    input [31:0] operand_b,
    input [2:0] alu_op,
    output reg [31:0] alu_result
);

always @(*) begin
    case (alu_op)
        3'b000: alu_result = operand_a + operand_b; // ADD
        3'b001: alu_result = operand_a - operand_b; // SUB
        3'b010: alu_result = operand_a & operand_b; // AND
        3'b011: alu_result = operand_a | operand_b; // OR
        3'b100: alu_result = operand_a ^ operand_b; // XOR
        3'b101: alu_result = {31'b0, $signed(operand_a) < $signed(operand_b)}; // SLT
        3'b110: alu_result = {31'b0, operand_a < operand_b}; // SLTU
        // SLL
        // SRL
        // SRA

        

    endcase
end

endmodule
