module data_write_mux
(
	input [31:0] data_old,
	input [31:0] data_new,
	input [1:0] write_addr,
	input [1:0] write_op,
	output reg [31:0] data_out
);

parameter STOREOP_SB  = 2'b00;
parameter STOREOP_SH  = 2'b01;
parameter STOREOP_SW  = 2'b10;

reg [31:0] b;
reg [31:0] h;
reg [31:0] w;

always @(*) begin

	// byte
	case (write_addr[1:0])
		2'b00: b = {data_old[31:8], data_new[7:0]};
		2'b01: b = {data_old[31:16], data_new[7:0], data_old[7:0]};
		2'b10: b = {data_old[31:24], data_new[7:0], data_old[15:0]};
		2'b11: b = {data_new[7:0], data_old[23:0]};
	endcase
	
	// half
	case (write_addr[1])
		1'b0: h = {data_old[31:16], data_new[15:0]};
		1'b1: h = {data_new[15:0], data_old[15:0]};
	endcase
	
	// word
	w = data_new;
	
	
	case (write_op)
		STOREOP_SB: data_out = b;
		STOREOP_SH: data_out = h;
		STOREOP_SW: data_out = w;
		default: data_out = w;
	endcase
	
end


endmodule
