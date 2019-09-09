
module data_demux_32_w (
					input 		 clk,
					input [7:0]  select,
					input [15:0] data_in,
					input 		 data_strb,
					input        crc_valid,
					input 		 reset,
											output reg [15:0] data_0,
											output reg [15:0] data_1,
											output reg [15:0] data_2,
											output reg [15:0] data_3,
											output reg [15:0] data_4,
											output reg [15:0] data_5,
											output reg [15:0] data_6,
											output reg [15:0] data_7,
											output reg [15:0] data_8,
											output reg [15:0] data_9,
											output reg [15:0] data_10,
											output reg [15:0] data_11,
											output reg [15:0] data_12,
											output reg [15:0] data_13,
											output reg [15:0] data_14,
											output reg [15:0] data_15,
											output reg [15:0] data_16,
											output reg [15:0] data_17,
											output reg [15:0] data_18,
											output reg [15:0] data_19,
											output reg [15:0] data_20,
											output reg [15:0] data_21,
											output reg [15:0] data_22,
											output reg [15:0] data_23,
											output reg [15:0] data_24,
											output reg [15:0] data_25,
											output reg [15:0] data_26,
											output reg [15:0] data_27,
											output reg [15:0] data_28,
											output reg [15:0] data_29,
											output reg [15:0] data_30,
											output reg [15:0] data_31,
											output reg        receive_done
																			);

parameter [7:0] n_word = 8'h01;

localparam [7:0] max_wrd_indx = n_word - 8'h01;

(*ramstyle = "no_rw_check"*)reg [15:0] mem [max_wrd_indx:0];

reg [15:0] data_bf = 16'h0000;
reg [7:0]  n       = 8'h00;

reg pre_strb_0 = 1'b0;
reg pre_strb_1 = 1'b0;
reg valid_flg  = 1'b0;
reg first_word = 1'b0;


always @(posedge clk) begin
	pre_strb_0 <= data_strb;
	pre_strb_1 <= crc_valid;

	if(data_strb && !pre_strb_0) begin
		mem[select] <= data_in;
	end
	else begin
		if(valid_flg) begin
			if(!first_word) begin
				n <= 8'h00;
				data_bf <= mem[0];
				first_word <= 1'b1;
				if(!max_wrd_indx) begin
					valid_flg <= 1'b0;
					receive_done <= 1'b1;
				end
				else begin end
			end
			else begin
				data_bf <= mem[n + 8'h01];
				n <= n + 8'h01;
				if(n == max_wrd_indx - 8'h01) begin
					valid_flg <= 1'b0;
					receive_done <= 1'b1;	
				end
				else begin end
			end
		end
		else begin end
	end
	if(crc_valid && !pre_strb_1) begin
		valid_flg <= 1'b1;
		receive_done <= 1'b0;
		first_word <= 1'b0;	
	end
	else begin end

	if(reset) begin
		valid_flg <= 1'b0;
		first_word <= 1'b0;
		receive_done <= 1'b0;
	end
	else begin end
end

always @(posedge clk) begin
	if(reset) begin
		data_0 <= 16'h0000;
		data_1 <= 16'h0000;
		data_2 <= 16'h0000;
		data_3 <= 16'h0000;
		data_4 <= 16'h0000;
		data_5 <= 16'h0000;
		data_6 <= 16'h0000;
		data_7 <= 16'h0000;
		data_8 <= 16'h0000;
		data_9 <= 16'h0000;
		data_10 <= 16'h0000;
		data_11 <= 16'h0000;
		data_12 <= 16'h0000;
		data_13 <= 16'h0000;
		data_14 <= 16'h0000;
		data_15 <= 16'h0000;
		data_16 <= 16'h0000;
		data_17 <= 16'h0000;
		data_18 <= 16'h0000;
		data_19 <= 16'h0000;
		data_20 <= 16'h0000;
		data_21 <= 16'h0000;
		data_22 <= 16'h0000;
		data_23 <= 16'h0000;
		data_24 <= 16'h0000;
		data_25 <= 16'h0000;
		data_26 <= 16'h0000;
		data_27 <= 16'h0000;
		data_28 <= 16'h0000;
		data_29 <= 16'h0000;
		data_30 <= 16'h0000;
		data_31 <= 16'h0000;
	end
	else begin
		case(n)
			0: data_0 <= data_bf;
			1: data_1 <= data_bf;
			2: data_2 <= data_bf;
			3: data_3 <= data_bf;
			4: data_4 <= data_bf;
			5: data_5 <= data_bf;
			6: data_6 <= data_bf;
			7: data_7 <= data_bf;
			8: data_8 <= data_bf;
			9: data_9 <= data_bf;
			10: data_10 <= data_bf;
			11: data_11 <= data_bf;
			12: data_12 <= data_bf;
			13: data_13 <= data_bf;
			14: data_14 <= data_bf;
			15: data_15 <= data_bf;
			16: data_16 <= data_bf;
			17: data_17 <= data_bf;
			18: data_18 <= data_bf;
			19: data_19 <= data_bf;
			20: data_20 <= data_bf;
			21: data_21 <= data_bf;
			22: data_22 <= data_bf;
			23: data_23 <= data_bf;
			24: data_24 <= data_bf;
			25: data_25 <= data_bf;
			26: data_26 <= data_bf;
			27: data_27 <= data_bf;
			28: data_28 <= data_bf;
			29: data_29 <= data_bf;
			30: data_30 <= data_bf;
			31: data_31 <= data_bf;	

			default: begin end
		endcase
	end
end
endmodule 