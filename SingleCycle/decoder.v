module decoder
(
	input [31:0] instr,
	output reg [31:0] imm,
	output reg [4:0] rs1,
	output reg [2:0] alu_opcode,
	output reg alu_special,
	output reg [4:0] rd
);

parameter OP_STORE  = 5'b01000;
parameter OP_BRANCH = 5'b11000;
parameter OP_JAL    = 5'b11011;
parameter OP_LUI    = 5'b01101;
parameter OP_AUIPC  = 5'b00101;

wire [4:0] opcode = instr[6:2];
wire [2:0] funct3 = instr[14:12];
wire [6:0] funct7 = instr[31:25];

always @(*) begin
	case (opcode)
		OP_STORE: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type
		OP_BRANCH: imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type
		OP_JAL: imm = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type
		OP_LUI, OP_AUIPC: imm = {instr[31:12], {12{1'b0}}}; // U-type
		default: imm = {{20{instr[31]}}, instr[31:20]}; // I-type, R-type
	endcase
end

endmodule
