module data_read_mux
(
	input [31:0] data_in,
	input [1:0] read_addr,
	input [2:0] read_op,
	output reg [31:0] data_out
);

parameter LOADOP_LB  = 3'b000;
parameter LOADOP_LH  = 3'b001;
parameter LOADOP_LW  = 3'b010;
parameter LOADOP_LBU  = 3'b100;
parameter LOADOP_LHU  = 3'b101;

reg [7:0] b;
reg [15:0] h;
reg [31:0] w;

always @(*) begin

	// byte
	case (read_addr[1:0])
		2'b00: b = data_in[7:0];
		2'b01: b = data_in[15:8];
		2'b10: b = data_in[23:16];
		2'b11: b = data_in[31:24];
	endcase
	
	// half
	case (read_addr[1])
		1'b0: h = data_in[15:0];
		1'b1: h = data_in[31:16];
	endcase
	
	// word
	w = data_in;
	
	
	case (read_op)
		LOADOP_LB: data_out = {{24{b[7]}}, b[7:0]};
		LOADOP_LH: data_out = {{16{h[15]}}, h[15:0]};
		LOADOP_LW: data_out = w[31:0];
		LOADOP_LBU: data_out = {{24{1'b0}}, b[7:0]};
		LOADOP_LHU: data_out = {{16{1'b0}}, h[15:0]};
		default: data_out = w[31:0];
	endcase
	
end


endmodule
