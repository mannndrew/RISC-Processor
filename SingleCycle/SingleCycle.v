module SingleCycle
(
	input clk,
	input rst,
	input button,
	output [7:0] led
);

wire debounced;
wire [31:0] pc_address;

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
	.address(pc_address >> 2),
	.clock(clk),
	.q(led[7:0])
);

decoder DEC
(
	.instruction(),
	.imm(),
	.rs1(),
	.alu_opcode(),
	.rd()
);



endmodule