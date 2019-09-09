module error (input clk, input [7:0] error, input reset, output reg [15:0] error_out, output reg error_0);

reg flag;
reg [31:0] count;

always @(posedge clk) begin 



if(error < 8'b11111111) begin
	error_0 <= 1;
	flag <= 1;
	error_out[7:0] <= error [7:0];
	end
else begin 
 end
 
if(flag)
	count <= count + 1;
else
	error_out[7:0] <= error [7:0];
 
if(count >= 20_000_000) begin
	count <= 0;
	flag <= 0;
end


if(reset)
	error_0 <= 0;
else begin end


end

endmodule 