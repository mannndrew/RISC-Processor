module decoder
(
	input [31:0] instruction,
	output [2:0] alu_opcode,
);

wire [6:0] opcode = instruction[6:0];
wire 

always @(opcode) begin
	case (opcode)
		0010011: begin
			alu_opcode = ; // ALU Add
			
		end
	endcase
end

//1. ADDI: I-type [Add Immediate] {1 Cycle}
//   | 31-20     | 19-15 | 14-12 | 11-7 | 6-0     |
//   | imm[11:0] | rs1   | 000   | rd   | 0010011 |
//     x[rd] = x[rs1] + sext(immediate)
//     In: Reg & Imm
//     Out: Reg