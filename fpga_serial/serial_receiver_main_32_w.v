
/*
	Developer: Sokolov R.V.
	Revision: 1.0

	Max clk freq: 600 MHz
	Max data rate: 150 Mbit/s ( Max clk freq / 4 )
	Data packet length [bit]: 32 + (20 * n_words) 

	If 'reset' port not use: connect 'reset' port to GND.
	End receive: posedge signal on 'receive_done' port.

	Add this file and all dependent files to project and
	create symbol from this file.

	Dependent files:
		- data_demux_32_w.v
		- serial_rx_ctrl_32_w.v
		- crc_16_rtu_rx_32_w.v
		- serial_receiver_32_w.v
*/

module serial_receiver_main_32_w(
	clk,
	rx,
	reset,
	data_0,
	data_1,
	data_2,
	data_3,
	data_4,
	data_5,
	data_6,
	data_7,
	data_8,
	data_9,
	data_10,
	data_11,
	data_12,
	data_13,
	data_14,
	data_15,
	data_16,
	data_17,
	data_18,
	data_19,
	data_20,
	data_21,
	data_22,
	data_23,
	data_24,
	data_25,
	data_26,
	data_27,
	data_28,
	data_29,
	data_30,
	data_31,
	receive_done,
	errors_count
);

input wire	clk;
input wire	rx;
input wire	reset;
output wire	[15:0] data_0;
output wire	[15:0] data_1;
output wire	[15:0] data_2;
output wire	[15:0] data_3;
output wire	[15:0] data_4;
output wire	[15:0] data_5;
output wire	[15:0] data_6;
output wire	[15:0] data_7;
output wire	[15:0] data_8;
output wire	[15:0] data_9;
output wire	[15:0] data_10;
output wire	[15:0] data_11;
output wire	[15:0] data_12;
output wire	[15:0] data_13;
output wire	[15:0] data_14;
output wire	[15:0] data_15;
output wire	[15:0] data_16;
output wire	[15:0] data_17;
output wire	[15:0] data_18;
output wire	[15:0] data_19;
output wire	[15:0] data_20;
output wire	[15:0] data_21;
output wire	[15:0] data_22;
output wire	[15:0] data_23;
output wire	[15:0] data_24;
output wire	[15:0] data_25;
output wire	[15:0] data_26;
output wire	[15:0] data_27;
output wire	[15:0] data_28;
output wire	[15:0] data_29;
output wire	[15:0] data_30;
output wire	[15:0] data_31;

output wire	receive_done;
output wire	[15:0] errors_count;

wire	[7:0] byte_out;
reg	clk_dev_4;
wire	[15:0] crc_16;
wire	crc_busy;
wire	crc_reset;
wire	crc_valid;
wire	[7:0] d_select;
wire	d_strb;
wire	[15:0] data;
wire	[15:0] err_cnt;
wire	main_reset;
wire	ready_rx;
reg	rx_syn;
wire	tmout;
reg	DFF_inst1;
wire	SYNTHESIZED_WIRE_0;
reg	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_1;





serial_receiver_32_w	b2v_inst(
	.clk(clk),
	.rx(rx_syn),
	.ready(ready_rx),
	.timeout(tmout),
	.byte_out(byte_out));


always@(posedge clk)
begin
	begin
	DFF_inst1 <= rx;
	end
end


always@(posedge clk)
begin
	begin
	rx_syn <= DFF_inst1;
	end
end


always@(posedge clk)
begin
	begin
	SYNTHESIZED_WIRE_2 <= SYNTHESIZED_WIRE_0;
	end
end


always@(posedge SYNTHESIZED_WIRE_2)
begin
	begin
	clk_dev_4 <= SYNTHESIZED_WIRE_1;
	end
end

assign	SYNTHESIZED_WIRE_1 =  ~clk_dev_4;

assign	SYNTHESIZED_WIRE_0 =  ~SYNTHESIZED_WIRE_2;


serial_rx_ctrl_32_w	b2v_inst7(
	.clk(clk_dev_4),
	.rx_done(ready_rx),
	.tmout(tmout),
	.crc_busy(crc_busy),
	.reset(main_reset),
	.byte_in(byte_out),
	.crc_16(crc_16),
	.data_strb(d_strb),
	.validate(crc_valid),
	.crc_reset(crc_reset),
	.data_out(data),
	.errors_cnt(err_cnt),
	.selector(d_select));
	defparam	b2v_inst7.n_word = 32;


crc_16_rtu_rx_32_w	b2v_inst8(
	.clk(clk_dev_4),
	.start(ready_rx),
	.reset(crc_reset),
	.byte_in(byte_out),
	.busy(crc_busy),
	.crc_16(crc_16));


data_demux_32_w	b2v_inst9(
	.clk(clk_dev_4),
	.data_strb(d_strb),
	.crc_valid(crc_valid),
	.reset(main_reset),
	.data_in(data),
	.select(d_select),	
	.data_0(data_0),	
	.data_1(data_1),	
	.data_2(data_2),	
	.data_3(data_3),	
	.data_4(data_4),	
	.data_5(data_5),	
	.data_6(data_6),	
	.data_7(data_7),	
	.data_8(data_8),	
	.data_9(data_9),	
	.data_10(data_10),	
	.data_11(data_11),	
	.data_12(data_12),	
	.data_13(data_13),	
	.data_14(data_14),	
	.data_15(data_15),	
	.data_16(data_16),	
	.data_17(data_17),	
	.data_18(data_18),	
	.data_19(data_19),	
	.data_20(data_20),	
	.data_21(data_21),	
	.data_22(data_22),	
	.data_23(data_23),	
	.data_24(data_24),	
	.data_25(data_25),	
	.data_26(data_26),	
	.data_27(data_27),	
	.data_28(data_28),	
	.data_29(data_29),	
	.data_30(data_30),	
	.data_31(data_31),
	.receive_done(receive_done));
	defparam	b2v_inst9.n_word = 32;

assign	main_reset = reset;
assign	errors_count = err_cnt;

endmodule