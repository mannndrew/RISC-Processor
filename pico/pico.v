
module pico
(
   input clk,
	input rst,
	input [31:0] mem_rdata,
	output mem_valid,
	output mem_instr,
	output [31:0] mem_addr,
	output [31:0] mem_wdata,
	output [3:0] mem_wstrb
);

picorv32 
#(
	.ENABLE_COUNTERS(0),
	.LATCHED_MEM_RDATA(1),
	.TWO_STAGE_SHIFT(0),
	.CATCH_MISALIGN(0),
	.CATCH_ILLINSN(0)
) picorv32 (
	.clk      (clk), // Input: Clock
	.resetn   (rst      ), // Input: Reset
	.mem_valid(mem_valid            ), // Output: Indicates that a valid memory operation is happening.
	.mem_instr(mem_instr            ), // Output: Indicates whether the memory operation is an instruction fetch.
	.mem_ready(1'b1        ), // Input: Signals processor that memory is ready.
	.mem_addr (mem_addr    ), // Output: Address to memory.
	.mem_wdata(mem_wdata   ), // Output: Data to memory.
	.mem_wstrb(mem_wstrb   ), // Output: Write enable certain bytes.
	.mem_rdata(mem_rdata   )  // Input: Memory data to processor.
);

//module pico (
//	input         clk, 
//	input         resetn,
//	input         switch,
//   output  [7:0] led
//);
//
//wire [31:0] mem_addr;
//wire [31:0] mem_rdata;
//wire [31:0] mem_wdata;
//wire [3:0] mem_wstrb;
//wire [31:0] value;
//
//assign led = value[7:0];
//
//picorv32 
//#(
//	.ENABLE_COUNTERS(0),
//	.LATCHED_MEM_RDATA(1),
//	.TWO_STAGE_SHIFT(0),
//	.CATCH_MISALIGN(0),
//	.CATCH_ILLINSN(0)
//) picorv32 (
//	.clk      (clk & switch), // Input: Clock
//	.resetn   (resetn      ), // Input: Reset
//	.mem_valid(            ), // Output: Indicates that a valid memory operation is happening.
//	.mem_instr(            ), // Output: Indicates whether the memory operation is an instruction fetch.
//	.mem_ready(1'b1        ), // Input: Signals processor that memory is ready.
//	.mem_addr (mem_addr    ), // Output: Address to memory.
//	.mem_wdata(mem_wdata   ), // Output: Data to memory.
//	.mem_wstrb(mem_wstrb   ), // Output: Write enable certain bytes.
//	.mem_rdata(mem_rdata   )  // Input: Memory data to processor.
//);
//
//
//
//ram ram_inst
//(
//	.address_a (mem_addr[16:2]),
//	.address_b (15'h0100      ),
//	.byteena_a (mem_wstrb     ),
//	.clock     (~clk & switch  ),
//	.data_a    (mem_wdata     ),
//	.data_b    (32'b0         ),
//	.wren_a    (|mem_wstrb    ),
//	.wren_b    (1'b0          ),
//	.q_a       (mem_rdata     ),
//	.q_b       (value         )
//);
	
	

endmodule
