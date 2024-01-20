module decoder
(
	input [31:0] instruction,
	output reg [11:0] imm,
	output reg [4:0] rs1,
	output reg [2:0] alu_opcode,
	output reg [4:0] rd
);

wire [6:0] opcode = instruction[6:0];

always @(opcode) begin
	case (opcode)
		0010011: begin
			imm = instruction[31:20];
			rs1 = instruction[19:15];
			alu_opcode = instruction[14:12];
			rd = instruction[11:7];
		end
		
		default: begin
			imm = 12'd0;
			rs1 = 5'd0;
			alu_opcode = 3'd0;
			rd = 5'd0;
		end
	endcase
end

endmodule
