module decoder
(
	input [31:0] instr,
	output reg [31:0] imm,
	output [4:0] rs1,
	output [4:0] rs2,
	output reg [3:0] alu_op,
	output reg [4:0] rd
);

parameter OP_STORE  = 5'b01000; // S-type
parameter OP_LOAD   = 5'b00000; // I-type
parameter OP_BRANCH = 5'b11000; // B-type
parameter OP_JAL    = 5'b11011; // J-type
parameter OP_JALR   = 5'b11001; // I-type
parameter OP_REG    = 5'b01100; // R-type
parameter OP_LUI    = 5'b01101; // U-type
parameter OP_AUIPC  = 5'b00101; // U-type
parameter OP_IMM    = 5'b00100; // I-type

parameter FUNC_ADD_SUB  = 3'b000;
parameter FUNC_SLL  = 3'b001;
parameter FUNC_SLT  = 3'b010;
parameter FUNC_SLTI  = 3'b011;
parameter FUNC_XOR  = 3'b100;
parameter FUNC_SRL_SRA  = 3'b101;
parameter FUNC_OR  = 3'b110;
parameter FUNC_AND  = 3'b111;

parameter ALUOP_ADD  = 4'b0000;
parameter ALUOP_SUB  = 4'b0001;
parameter ALUOP_AND  = 4'b0010;
parameter ALUOP_OR  = 4'b0011;
parameter ALUOP_XOR  = 4'b0100;
parameter ALUOP_SLT  = 4'b0101;
parameter ALUOP_SLTU  = 4'b0110;
parameter ALUOP_SLL  = 4'b0111;
parameter ALUOP_SRL  = 4'b1000;
parameter ALUOP_SRA  = 4'b1001;


wire [4:0] opcode = instr[6:2];
wire [2:0] funct3 = instr[14:12];
wire [6:0] funct7 = instr[31:25];

assign rs1 = (opcode == OP_LUI) ? 5'b00000 : instr[19:15];
assign rs2 = instr[24:20];

reg [3:0] alu_op_imm;
reg [3:0] alu_op_reg;

always @(*) begin

	// imm
	case (opcode)
		OP_STORE: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type
		OP_BRANCH: imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type
		OP_JAL: imm = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type
		OP_LUI, OP_AUIPC: imm = {instr[31:12], {12{1'b0}}}; // U-type
		default: imm = {{20{instr[31]}}, instr[31:20]}; // I-type, R-type
	endcase
	
	// alu_op_imm
	case (funct3)
		FUNC_ADD_SUB: alu_op_imm = ALUOP_ADD;
		FUNC_SLL: alu_op_imm = ALUOP_SLL;
		FUNC_SLT: alu_op_imm = ALUOP_SLT;
		FUNC_SLTI: alu_op_imm = ALUOP_SLTU;
		FUNC_XOR: alu_op_imm = ALUOP_XOR;
		FUNC_SRL_SRA: alu_op_imm = (funct7[5]) ? ALUOP_SRA : ALUOP_SRL;
		FUNC_OR: alu_op_imm = ALUOP_OR;
		FUNC_AND: alu_op_imm = ALUOP_AND;
		default: alu_op_imm = ALUOP_ADD;
	endcase
	
	// alu_op_reg
	case (funct3)
		FUNC_ADD_SUB: alu_op_reg = (funct7[5]) ? ALUOP_SUB : ALUOP_ADD;
		FUNC_SLL: alu_op_reg = ALUOP_SLL;
		FUNC_SLT: alu_op_reg = ALUOP_SLT;
		FUNC_SLTI: alu_op_reg = ALUOP_SLTU;
		FUNC_XOR: alu_op_reg = ALUOP_XOR;
		FUNC_SRL_SRA: alu_op_reg = (funct7[5]) ? ALUOP_SRA : ALUOP_SRL;
		FUNC_OR: alu_op_reg = ALUOP_OR;
		FUNC_AND: alu_op_reg = ALUOP_AND;
		default: alu_op_reg = ALUOP_ADD;
	endcase
	
	// alu_op
	case (opcode)
		OP_IMM: alu_op = alu_op_imm;
		OP_REG: alu_op = alu_op_reg;
		default: alu_op = ALUOP_ADD;
	endcase
	
	// rd
	case (opcode)
		OP_IMM, OP_LUI, OP_AUIPC, OP_REG, OP_JAL, OP_JALR, OP_LOAD: rd = instr[11:7];
		default: rd = 5'd0;
	endcase
	
end

endmodule
