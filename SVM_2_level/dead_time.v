module dead_time (input clk, input K_in, output reg K_out);

reg [10:0] count;
reg old_k;
reg flag_delay;

initial begin
	K_out = 0;
	old_k = 0;
	count = 0;
	flag_delay = 0;
end

always @(posedge clk) begin
	
	if(K_in == 1 && old_k == 0) begin
		flag_delay <= 1;
		count = 0;
	end
		
	if(flag_delay == 1)
		count = count + 1;
	else begin end
		
	if(count >= 200) begin
		K_out <= K_in;
		flag_delay <= 0;
	end
	else begin end
		
	old_k <= K_in;
	
end
endmodule