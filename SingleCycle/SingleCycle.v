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

wire [31:0] pc_in;
wire [31:0] pc_next;
wire branch;

wire [31:0] dec_imm;
wire [4:0] dec_rs1;
wire [4:0] dec_rs2;
wire dec_data_ena_write;
wire dec_data_ena_read;
wire dec_pcmux;
wire dec_regmux;
wire dec_alumux1;
wire dec_alumux2;
wire [3:0] dec_branchop;
wire [3:0] dec_aluop;
wire [4:0] dec_rd;

wire [31:0] reg_in;
wire [31:0] reg_rs1;
wire [31:0] reg_rs2;

wire [31:0] alu_dataS1;
wire [31:0] alu_dataS2;
wire [31:0] alu_result;

wire [31:0] data_out;

assign pc_in = (dec_pcmux || branch) ? alu_result : pc_next;

pccounter pgcounter_unit
(
	.clk(clk),
	.rst(rst),
	.pc_in(pc_in),
	.pc_next(pc_next),
	.pc_out(pc_address)
);

decoder decoder_unit
(
	// Inputs
	.instr(instr),
	
	// Outputs
	.imm(dec_imm),
	.rs1(dec_rs1),
	.rs2(dec_rs2),
	.data_write_enable(dec_data_ena_write),
	.data_read_enable(dec_data_ena_read),
	.pcmux(dec_pcmux),
	.regmux(dec_regmux),
	.alumux1(dec_alumux1),
	.alumux2(dec_alumux2),
	.branchop(dec_branchop),
	.aluop(dec_aluop),
	.rd(dec_rd)
);

branch branch_unit
(
	.dataS1(reg_rs1),
	.dataS2(reg_rs2),
	.branchop(dec_branchop),
	.branch(branch)
);

assign reg_in = (dec_regmux) ? pc_next : alu_result;

regfile register_unit
(
	// Inputs
	.clk(clk),
	.write_addr(dec_rd),
	.write_data(reg_in),
	.read_addr_1(dec_rs1),
	.read_addr_2(dec_rs2),
	
	// Outputs
	.read_data_1(reg_rs1),
	.read_data_2(reg_rs2),
	.reg1_data(reg1_output)
);

assign alu_dataS1 = (dec_alumux1) ? pc_address : reg_rs1;
assign alu_dataS2 = (dec_alumux2) ? dec_imm : reg_rs2;

alu arithmetic_unit
(
	// Inputs
	.dataS1(alu_dataS1),
	.dataS2(alu_dataS2),
	.aluop(dec_aluop),
	
	// Outputs
	.result(alu_result)
);


data_memory data_unit 
(
	// Write Port (Posedge Clock)
//	.address_a(alu_result),
//	.clock_a(clk),
//	.data_a(reg_rs2),
//	.enable_a(dec_data_ena_write),
//	.wren_a(dec_data_ena_write),
	
	
	// Read Port (Negedge Clock)
	.address_b(alu_result),
	.clock_b(~clk),
	.enable_b(dec_data_ena_read),
	.q_b(data_out)
);


assign alu_output = alu_result;

endmodule
