## Copyright (C) 1991-2009 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.

## VENDOR "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 9.1 Build 222 10/21/2009 SJ Full Version"

## DATE "08/31/2018 11:08:38"

## 
## Device: Altera EP2C20Q240C8 Package PQFP240
## 

## 
## This Tcl script should be used for PrimeTime (Verilog) only
## 

## This file can be sourced in primetime

set report_default_significant_digits 3
set hierarchy_separator .

set quartus_root "c:/altera/91/quartus/"
set search_path [list . [format "%s%s" $quartus_root "eda/synopsys/primetime/lib"]  ]

set link_path [list *  cycloneii_lcell_comb_lib.db  cycloneii_lcell_ff_lib.db  cycloneii_asynch_io_lib.db  bb2_lib.db  cycloneii_ram_internal_lib.db  cycloneii_memory_register_lib.db  cycloneii_memory_addr_register_lib.db  cycloneii_clk_delay_ctrl_lib.db  cycloneii_clk_delay_cal_ctrl_lib.db  cycloneii_mac_out_lib.db cycloneii_mac_mult_internal_lib.db  cycloneii_mac_register_lib.db  cycloneii_pll_lib.db  alt_vtl.db]

read_verilog  cycloneii_all_pt.v 

##########################
## DESIGN ENTRY SECTION ##
##########################

read_verilog  svm.vo
current_design svm
link
## Set variable timing_propagate_single_condition_min_slew to false only for versions 2004.06 and earlier
regexp {([1-9][0-9][0-9][0-9]\.[0-9][0-9])} $sh_product_version dummy version
if { [string compare "2004.06" $version ] != -1 } {
   set timing_propagate_single_condition_min_slew false
}
set_operating_conditions -analysis_type single
read_sdf svm_v.sdo

################################
## TIMING CONSTRAINTS SECTION ##
################################


## Start clock definition ##
create_clock -period 25.000 -waveform {0.000 12.500} [get_ports { clk } ] -name clk  
create_generated_clock -edges {1 2 3} -edge_shift {0.000 12.500 25.000} -source inst3|altpll_component|pll.inclk[0] -name PLL_1_clk0 [get_pins inst3|altpll_component|pll.clk[0]]
create_generated_clock -edges {1 2 3} -edge_shift {0.000 37.500 75.000} -source inst3|altpll_component|pll.inclk[0] -name PLL_1_clk1 [get_pins inst3|altpll_component|pll.clk[1]]

set_propagated_clock [all_clocks]

## End clock definition ##

## Start create collections ##
## End create collections ##

## Start global settings ##
## End global settings ##

## Start collection commands definition ##

## End collection commands definition ##

## Start individual pin commands definition ##
## End individual pin commands definition ##

## Start Output pin capacitance definition ##
set_load -pin_load 0 [get_ports { BRAKE_1 } ]
set_load -pin_load 0 [get_ports { BRAKE_2 } ]
set_load -pin_load 0 [get_ports { U1 } ]
set_load -pin_load 0 [get_ports { U2 } ]
set_load -pin_load 0 [get_ports { U_N_1 } ]
set_load -pin_load 0 [get_ports { U_N_2 } ]
set_load -pin_load 0 [get_ports { U_P_1 } ]
set_load -pin_load 0 [get_ports { U_P_2 } ]
set_load -pin_load 0 [get_ports { V_N_1 } ]
set_load -pin_load 0 [get_ports { V_N_2 } ]
set_load -pin_load 0 [get_ports { V_P_1 } ]
set_load -pin_load 0 [get_ports { V_P_2 } ]
set_load -pin_load 0 [get_ports { W_N_1 } ]
set_load -pin_load 0 [get_ports { W_N_2 } ]
set_load -pin_load 0 [get_ports { W_P_1 } ]
set_load -pin_load 0 [get_ports { W_P_2 } ]
set_load -pin_load 0 [get_ports { eth_clk_1 } ]
set_load -pin_load 0 [get_ports { eth_clk_2 } ]
set_load -pin_load 0 [get_ports { eth_cs_1 } ]
set_load -pin_load 0 [get_ports { eth_cs_2 } ]
set_load -pin_load 0 [get_ports { eth_mosi_1 } ]
set_load -pin_load 0 [get_ports { eth_mosi_2 } ]
set_load -pin_load 0 [get_ports { mod_bus_adm } ]
set_load -pin_load 0 [get_ports { mod_bus_tx } ]
## End Output pin capacitance definition ##

## Start clock uncertainty definition ##
## End clock uncertainty definition ##

## Start Multicycle and Cut Path definition ##
## End Multicycle and Cut Path definition ##

## Destroy Collections ##

update_timing
