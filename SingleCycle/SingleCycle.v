module SingleCycle
(
	input clk,
	input rst,
	input button,
	output [31:0] led
);

wire debounced;
wire [31:0] pc_address;
wire [31:0] instr;

wire [11:0] imm;
wire [4:0] rs1;
wire [2:0] alu_opcode;
wire [4:0] rd;

debounce DEB
(
	.clk(clk),
	.rst(rst),
	.button(~button),
	.debounced(debounced)
);

pccounter PC
(
	.clk(debounced),
	.rst(rst),
	.pc_address(pc_address)
);

instruction_memory BR1
(
	.address(pc_address[9:2]),
	.clock(clk),
	.q(instr)
);

decoder DEC
(
	.instr(instr),
	.imm(led),
	.rs1(),
	.alu_opcode(),
	.rd()
);



endmodule