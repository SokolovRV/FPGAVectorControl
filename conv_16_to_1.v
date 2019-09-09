module conv_16_to_1 (input clk, input [15:0]data_in, output reg out1, output reg out2, output reg out3, output reg out4, output reg out5, output reg out6, output reg out7, output reg out8, output reg out9, output reg out10);

initial begin out1 = 0; out2 = 0; out3 = 0; out4 = 0; out5 = 0; out6 = 0; end

always @(posedge clk) begin out1 <= data_in[0]; out2 <= data_in[1]; out3 <= data_in[2]; out4 <= data_in[3]; out5 <= data_in[4]; out6 <= data_in[5]; out7 <= data_in[6]; out8 <= data_in[7]; out9 <= data_in[8]; out10 <= data_in[9]; end

endmodule