## This file is a general .xdc for mux.vhdl the Zybo Z7 Rev. B
## It is compatible with the Zybo Z7-20 and Zybo Z7-10

##Switches
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { d0 }]; #IO_L19N_T3_VREF_35 Sch=sw[0]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { d1 }]; #IO_L24P_T3_34 Sch=sw[1]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { sel }]; #IO_L9P_T1_DQS_34 Sch=sw[3]

##LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { mux_out }]; #IO_L23P_T3_35 Sch=led[0]
