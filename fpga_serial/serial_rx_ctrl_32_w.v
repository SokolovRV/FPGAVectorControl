
module serial_rx_ctrl_32_w ( clk, rx_done, byte_in, tmout, crc_16, crc_busy, reset,
							data_out, selector, data_strb, validate, errors_cnt, crc_reset);

input clk, rx_done, tmout, crc_busy, reset;
input [7:0] byte_in;
input [15:0] crc_16;

output reg data_strb, validate, crc_reset;
output reg [7:0] selector;
output reg [15:0] data_out, errors_cnt;

parameter [7:0] n_word = 8'h01; 

localparam [7:0] max_wrd_indx = n_word - 8'h01;

localparam [2:0] IDLE    = 3'b000;
localparam [2:0] DATA_HI = 3'b001;
localparam [2:0] DATA_LO = 3'b010;
localparam [2:0] CRC_HI  = 3'b011;
localparam [2:0] CRC_LO  = 3'b100;
localparam [2:0] VALID   = 3'b101;

reg [2:0] state     = 3'b000;
reg [15:0] crc_hi_bf = 16'h0000;

reg pre_strb_0 = 1'b0;
reg fist_word  = 1'b0;
reg strb_bf    = 1'b0;

always @(posedge clk) begin
	strb_bf <= rx_done;
	pre_strb_0 <= strb_bf;

	if(reset) begin
		errors_cnt <= 16'h0000;
		state <= IDLE;
		validate <= 1'b0;
		data_strb <= 1'b0;
	end
	else begin
		case(state)
			IDLE: begin
				if(tmout) begin
					state <= DATA_HI;
					validate <= 1'b0;
				end
				else begin
					state <= IDLE;
				end
				fist_word <= 1'b0;
				selector <= 8'h00;
			end
			DATA_HI: begin
				if(!strb_bf)
					crc_reset <= 1'b0;
				else begin end
				data_strb <= 1'b0;
				if(strb_bf && !pre_strb_0) begin
					if(!fist_word) begin
						selector <= selector;
						fist_word <= 1'b1;
					end
					else begin
						selector <= selector + 8'h01;
					end
					data_out[15:8] <= byte_in;
					state <= DATA_LO;
				end

			end
			DATA_LO: begin
				if(strb_bf && !pre_strb_0) begin
					data_out[7:0] <= byte_in;
					data_strb <= 1'b1;
					if(selector == max_wrd_indx && fist_word) begin
						state <= CRC_HI;
					end
					else begin
						state <= DATA_HI;
					end
				end
			end
			CRC_HI: begin
				if(!crc_busy) begin
					crc_reset <= 1'b1;
				end
				else begin end
				if(strb_bf && !pre_strb_0) begin
					crc_hi_bf[15:8] <= byte_in;
					state <= CRC_LO;
				end
			end
			CRC_LO: begin
				data_strb <= 1'b0;
				if(strb_bf && !pre_strb_0) begin
					crc_hi_bf[7:0] <= byte_in;
					state <= VALID;
				end
			end
			VALID: begin
				if(crc_hi_bf == crc_16) begin
					validate <= 1'b1;
				end
				else begin
					errors_cnt <= errors_cnt + 16'h0001;
				end
				state <= IDLE;
			end
			default: state <= IDLE;
		endcase
	end
end
endmodule