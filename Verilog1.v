module error (input clk, input [11:0] error, output reg [15:0] error_out)

always @(posedge clk) if(error>0) error_out <= 1; else error_out <= 0;

endmodule 