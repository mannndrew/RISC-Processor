module data_read_mux
(
	input [31:0] data_in,
	input [1:0] read_addr
	input [2:0] read_op,
	output [31:0] data_out
);

reg [7:0] byte;
reg [15:0] half;
reg [31:0] word;

always @(*) begin

	// byte
	case (read_addr[1:0])
		2'b00: byte = data_in[7:0];
		2'b01: byte = data_in[15:8];
		2'b10: byte = data_in[23:16];
		2'b11: byte = data_in[31:24];
	endcase
	
	// byte
	case (read_addr[1])
		1'b0: half = data_in[15:0];
		1'b1: half = data_in[31:16];
	endcase
	
	// word
	word = data_in;
	
	
	case (read_op)
	endcase
	
end

