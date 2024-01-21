module SingleCycle
(
	input clk,
	input rst,
	input [31:0] instr,
	//input button,
	output [31:0] pc_address,
	output [31:0] alu_output,
	output [31:0] reg1_output
);

//wire debounced;
//wire [31:0] pc_address;
//wire [31:0] instr;

wire [31:0] imm;
wire [4:0] rs1;
wire [4:0] rs2;
wire [3:0] alu_op;
wire [4:0] rd;

wire [31:0] rs1_data;
wire [31:0] rs2_data;
wire [31:0] rd_data;

//debounce DEB
//(
//	.clk(clk),
//	.rst(rst),
//	.button(~button),
//	.debounced(debounced)
//);

pccounter PC
(
	.clk(clk),
	.rst(rst),
	.pc_address(pc_address)
);

//instruction_memory BR1
//(
//	.address(pc_address[9:2]),
//	.clock(debounced),
//	.q(instr)
//);

decoder DEC
(
	.instr(instr),
	.imm(imm),
	.rs1(rs1),
	.rs2(rs2),
	.alu_op(alu_op),
	.rd(rd)
);

alu LU
(
	.I_operandA(rs1_data),
	.I_operandB(imm),
	.I_aluop(alu_op),
	.O_result(rd_data)
);

regfile REG
(
	.clk(clk),
	.write_addr(rd),
	.read_addr_1(rs1),
	.read_addr_2(),
	.write_data(rd_data),
	.read_data_1(rs1_data),
	.read_data_2(),
	
	.reg1_output(reg1_output)
);

assign alu_output = rd_data;

endmodule