
module data_mux_32_w (
					input        clk,
					input        data_lock,
					input [7:0]  selector,
					input [15:0] data_0,
					input [15:0] data_1,
					input [15:0] data_2,
					input [15:0] data_3,
					input [15:0] data_4,
					input [15:0] data_5,
					input [15:0] data_6,
					input [15:0] data_7,
					input [15:0] data_8,
					input [15:0] data_9,
					input [15:0] data_10,
					input [15:0] data_11,
					input [15:0] data_12,
					input [15:0] data_13,
					input [15:0] data_14,
					input [15:0] data_15,
					input [15:0] data_16,
					input [15:0] data_17,
					input [15:0] data_18,
					input [15:0] data_19,
					input [15:0] data_20,
					input [15:0] data_21,
					input [15:0] data_22,
					input [15:0] data_23,
					input [15:0] data_24,
					input [15:0] data_25,
					input [15:0] data_26,
					input [15:0] data_27,
					input [15:0] data_28,
					input [15:0] data_29,
					input [15:0] data_30,
					input [15:0] data_31,
					input 		 reset,
												output reg [15:0] data_out
																				);

reg pre_strb = 1'b0;
																						
always @(posedge clk) begin
	pre_strb <= data_lock;
	
	if(reset)
		data_out <= 16'h0000;
	else begin
		if(data_lock && !pre_strb)
			case(selector)
				0: data_out <= data_0;
				1: data_out <= data_1;
				2: data_out <= data_2;
				3: data_out <= data_3;
				4: data_out <= data_4;
				5: data_out <= data_5;
				6: data_out <= data_6;
				7: data_out <= data_7;
				8: data_out <= data_8;
				9: data_out <= data_9;
				10: data_out <= data_10;
				11: data_out <= data_11;
				12: data_out <= data_12;
				13: data_out <= data_13;
				14: data_out <= data_14;
				15: data_out <= data_15;
				16: data_out <= data_16;
				17: data_out <= data_17;
				18: data_out <= data_18;
				19: data_out <= data_19;
				20: data_out <= data_20;
				21: data_out <= data_21;
				22: data_out <= data_22;
				23: data_out <= data_23;
				24: data_out <= data_24;
				25: data_out <= data_25;
				26: data_out <= data_26;
				27: data_out <= data_27;
				28: data_out <= data_28;
				29: data_out <= data_29;
				30: data_out <= data_30;
				31: data_out <= data_31;
				default: data_out <= data_out;
			endcase
		else begin end
	end
end
endmodule