########################################################################
#
#    FILE: Constraints file
#  VENDOR: Altera
# PROGRAM: Quartus II
# VERSION: Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition
#    DATE: Tue Aug 27 14:40:01 2019
#
########################################################################


#**************************************************************
# Create Clock
#**************************************************************

create_clock -name inst42 -period 25.000 -waveform { 0.000 12.500 } $_col51
create_clock -name inst41 -period 25.000 -waveform { 0.000 12.500 } $_col52
create_clock -name inst47 -period 25.000 -waveform { 0.000 12.500 } $_col53
create_clock -name inst49 -period 25.000 -waveform { 0.000 12.500 } $_col54
create_clock -name clk -period 50.000 -waveform { 0.000 25.000 } $_col43
create_clock -name SVM_2_level:inst1|pwm_triangle:inst|new_cycle -period 25.000 -waveform { 0.000 12.500 } $_col55
create_clock -name serial_receiver_main_32_w:inst2|clk_dev_4 -period 25.000 -waveform { 0.000 12.500 } $_col56
create_clock -name serial_receiver_main_32_w:inst2|SYNTHESIZED_WIRE_2 -period 25.000 -waveform { 0.000 12.500 } $_col57
create_clock -name SVM_2_level:inst1|pwm_triangle:inst|data_capture -period 25.000 -waveform { 0.000 12.500 } $_col58
create_clock -name serial_transmitter_main_32_w:inst3|clk_dev_4 -period 25.000 -waveform { 0.000 12.500 } $_col59
create_clock -name serial_transmitter_main_32_w:inst3|SYNTHESIZED_WIRE_3 -period 25.000 -waveform { 0.000 12.500 } $_col60
create_clock -name SB-All-EthernetSPI:inst13|SB-ethernet:inst|spi_master_v2:inst1|cs -period 25.000 -waveform { 0.000 12.500 } $_col61
create_clock -name SB-All-EthernetSPI_v1:inst6|SB-ethernet:inst|spi_master_v2:inst1|cs -period 25.000 -waveform { 0.000 12.500 } $_col62
create_clock -name SB-All-EthernetSPI_v1:inst6|inst69 -period 25.000 -waveform { 0.000 12.500 } $_col63
create_clock -name SB-All-EthernetSPI:inst13|inst69 -period 25.000 -waveform { 0.000 12.500 } $_col64


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Propagated Clock
#**************************************************************

set_propagated_clock [all_clocks]


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {  new_cycle  }] -group [get_clocks {  clk  }] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

