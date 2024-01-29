module slow
(
	input clk,
	output reg slow
);

reg [31:0] counter;
reg slow_clock;
reg button_reg;


always @(posedge clk) begin
	counter <= counter + 32'b1;
	
	slow <= slow ^ 1'b1;
	
end

endmodule
