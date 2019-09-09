
module serial_tx_ctrl_32_w ( clk, data_in, start, tx_done, crc_16, reset,
						byte_out, reset_crc, start_tx, ready, data_select, data_lock );

input        clk, start, tx_done, reset;
input [15:0] data_in, crc_16;

output reg [7:0] byte_out, data_select;
output reg       start_tx, ready, data_lock, reset_crc;

parameter [7:0] n_word = 8'h01;

localparam [2:0] IDLE      = 3'b000;
localparam [2:0] DELAY     = 3'b001;
localparam [2:0] FST_BYTE  = 3'b010;
localparam [2:0] SD_HI     = 3'b011;
localparam [2:0] SD_LO     = 3'b100;
localparam [2:0] SD_CRC_HI = 3'b101;
localparam [2:0] SD_CRC_LO = 3'b110;

reg [2:0]  state     =  3'b000;
reg [2:0]  delay_cnt =  3'b000;

reg pre_strb_1 = 1'b0;
reg fst_flg    = 1'b0;

always @(posedge clk) begin
	pre_strb_1 <= tx_done;
	
	if(reset) begin
		state <= IDLE;
		reset_crc <= 1'b1;
		data_select <= 8'h00;
		ready <= 1'b0;
		start_tx <= 1'b0;	
	end
	else begin	
		case(state)
			IDLE: begin
				if(start) begin
					ready <= 1'b0;
					data_lock <= 1'b1;
					reset_crc <= 1'b0;
					state <= DELAY;
				end
				else begin
					ready <= 1'b1;
					data_lock <= 1'b0;
					state <= IDLE;
				end
			end		
			DELAY: begin
				fst_flg <= 1'b0;
				
				if(&delay_cnt) begin
					delay_cnt <= 3'b000;
					state <= FST_BYTE;
				end
				else begin
					delay_cnt <= delay_cnt + 3'b001;
					state <= DELAY;
				end
			end	
			FST_BYTE: begin
				byte_out <= data_in[15:8];
				fst_flg <= 1'b1;
				if(fst_flg)
					start_tx <= 1'b0;
				else
					start_tx <= 1'b1;

				if(tx_done && !pre_strb_1) begin
					data_select <= data_select + 8'h01;
					data_lock <= 1'b1;
					byte_out <= data_in[7:0];
					start_tx <= 1'b1;
					state <= SD_LO;
				end
				else begin
					data_lock <= 1'b0;
					state <= FST_BYTE;
				end
			end	
			SD_HI: begin			
				if(tx_done && !pre_strb_1) begin
					data_select <= data_select + 8'h01;
					data_lock <= 1'b1;
					byte_out <= data_in[7:0];
					start_tx <= 1'b1;
					state <= SD_LO;
				end
				else begin
					start_tx <= 1'b0;
					data_lock <= 1'b0;
					state <= SD_HI;
				end
			end
			SD_LO: begin	
				if(tx_done && !pre_strb_1) begin	
					start_tx <= 1'b1;
					data_lock <= 1'b0;
					if(data_select == n_word) begin
						data_select <= 8'h00;
						byte_out <= crc_16[15:8];
						reset_crc <= 1'b1;
						state <= SD_CRC_HI;
					end
					else begin	
						byte_out <= data_in[15:8];
						state <= SD_HI;
					end
				end
				else begin
					start_tx <= 1'b0;
					state <= SD_LO;
				end
			end
			SD_CRC_HI: begin
				start_tx <= 1'b0;
				
				if(tx_done && !pre_strb_1) begin
					start_tx <= 1'b1;
					byte_out <= crc_16[7:0];
					state <= SD_CRC_LO;
				end
				else begin
					state <= SD_CRC_HI;
				end
			end
			SD_CRC_LO: begin
				start_tx <= 1'b0;
				if(tx_done && !pre_strb_1) begin
					state <= IDLE;
					ready <= 1'b1;
				end
				else begin
					state <= SD_CRC_LO;
				end
			end
			
			default: begin
				state <= IDLE;
			end	
		endcase
	end
end
endmodule