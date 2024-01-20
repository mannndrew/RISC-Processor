module debounce
(
	input clk,
	input rst,
	input button,
	output debounced
);

reg [15:0] clock_counter;
reg slow_clock;
reg button_reg;


always @(posedge clk, negedge rst) begin
	if (rst == 1'b0) begin
		clock_counter <= 16'd0;
		slow_clock <= 1'b0;
	end

	else begin
		if (clock_counter == 16'd24999) begin
			clock_counter <= 16'd0;
			slow_clock <= slow_clock ^ 1'b1;
		end
		
		else begin
			clock_counter <= clock_counter + 16'd1;
		end
	end
end

always @(posedge slow_clock) begin
	button_reg <= button;
end

assign debounced = button_reg;

endmodule
