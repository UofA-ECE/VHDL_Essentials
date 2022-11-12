## This file is a .xdc for the blinky project on the Zybo Z7 Rev. B
## It is compatible with the Zybo Z7-20 and Zybo Z7-10

##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clock }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
create_clock -name sys_clk_pin -period 8.00 -waveform {0.000 4.000} -add [get_ports { clock }];

##Switches
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { blink }]; #IO_L19N_T3_VREF_35 Sch=sw[0]

##LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led }]; #IO_L23P_T3_35 Sch=led[0]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { clock_divider }]; #IO_L3N_T0_DQS_AD1N_35 Sch=led[3]

