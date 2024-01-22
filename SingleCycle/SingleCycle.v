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

//debounce DEB
//(
//	.clk(clk),
//	.rst(rst),
//	.button(~button),
//	.debounced(debounced)
//);

//instruction_memory BR1
//(
//	.address(pc_address[9:2]),
//	.clock(debounced),
//	.q(instr)
//);

wire [31:0] dec_imm;
wire [4:0] dec_rs1;
wire [4:0] dec_rs2;
wire dec_alumux1;
wire [3:0] dec_aluop;
wire [4:0] dec_rd;

wire [31:0] reg_rs1;
wire [31:0] reg_rs2;

wire [31:0] alu_dataS1;
wire [31:0] alu_dataS2;
wire [31:0] alu_result;

pccounter PC
(
	.clk(clk),
	.rst(rst),
	.pc_address(pc_address)
);

decoder DEC
(
	// Inputs
	.instr(instr),
	
	// Outputs
	.imm(dec_imm),
	.rs1(dec_rs1),
	.rs2(dec_rs2),
	.alumux1(dec_alumux1),
	.aluop(dec_aluop),
	.rd(dec_rd)
);

regfile REG
(
	// Inputs
	.clk(clk),
	.write_addr(dec_rd),
	.write_data(alu_result),
	.read_addr_1(dec_rs1),
	.read_addr_2(),
	
	// Outputs
	.read_data_1(reg_rs1),
	.read_data_2(),
	.reg1_data(reg1_output)
);

assign alu_dataS1 = (dec_alumux1) ? pc_address : reg_rs1;
assign alu_dataS2 = dec_imm;

alu LU
(
	// Inputs
	.dataS1(alu_dataS1),
	.dataS2(alu_dataS2),
	.aluop(dec_aluop),
	
	// Outputs
	.result(alu_result)
);

assign alu_output = alu_result;

endmodule