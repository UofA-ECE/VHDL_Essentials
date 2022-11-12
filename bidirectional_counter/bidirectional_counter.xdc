## This file is the .xdc for the bidirectional_counter.vhdl
## It is compatible with the Zybo Z7-20 and Zybo Z7-10

##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clock }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
create_clock -name sys_clk_pin -period 8.00 -waveform {0.000 4.000} -add [get_ports { clock }];

##Switches
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { direction }]; #IO_L19N_T3_VREF_35 Sch=sw[0]

##Buttons
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { reset }]; #IO_L12N_T1_MRCC_35 Sch=btn[0]

##LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { count[3] }]; #IO_L23P_T3_35 Sch=led[0]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { count[2] }]; #IO_L23N_T3_35 Sch=led[1]
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { count[1] }]; #IO_0_35 Sch=led[2]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { count[0] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=led[3]

##RGB LED 6
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { clock_out }]; #IO_L8P_T1_AD10P_35 Sch=led6_b

