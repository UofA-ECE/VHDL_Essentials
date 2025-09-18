## -----------------------------------------------------------------------------
## Filename : keypad.xdc
## Author : Antonio Alejandro Andara Lara
## Date : 11-Apr-2023
## Design Name: keypad
## Module Name: VHDL_essentials
## Project Name: VHDL_essentials
## Description : Design for a 4x4 matrix keypad that turns on an led whenever 1
## or more keys are pressed. This is a simple implementation to use the entire
## keypad as an extra input button
## Additional Comments: This file is an .xdc for the Zybo Z7 XC7Z010CLG400-1 
## Copyright : University of Alberta, 2023
## Additional Comments: 
## License : CC0 1.0 Universal
## -----------------------------------------------------------------------------


##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clock }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
create_clock -name sys_clk_pin -period 8.00 -waveform {0.000 4.000} -add [get_ports { clock }];


##LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { clk_div }]; #IO_L23P_T3_35 Sch=led[0]


##RGB LED 6
set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { data_out }]; #IO_L6N_T0_VREF_35 Sch=led6_g
                                                                                                                                 
                                                                                                                                 
##Pmod Header JE                                                                                                                  
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { column[0] }]; #IO_L4P_T0_34 Sch=je[1]						 
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { column[1] }]; #IO_L18N_T2_34 Sch=je[2]                     
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { column[2] }]; #IO_25_35 Sch=je[3]                          
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { column[3] }]; #IO_L19P_T3_35 Sch=je[4]                     
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { row[0] }]; #IO_L3N_T0_DQS_34 Sch=je[7]                  
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { row[1] }]; #IO_L9N_T1_DQS_34 Sch=je[8]                  
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { row[2] }]; #IO_L20P_T3_34 Sch=je[9]                     
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { row[3] }]; #IO_L7N_T1_34 Sch=je[10]                    