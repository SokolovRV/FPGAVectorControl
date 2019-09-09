module convert_encoder (input clk, input [15:0] data_in, output reg [15:0] data_out);

initial begin
	data_out = 0;
end

always @(posedge clk) begin


	if(data_in[11]) begin
		data_out <= (data_in - 2048) * (-1);
	end
	else begin
		data_out <= data_in;
	end



end
endmodule