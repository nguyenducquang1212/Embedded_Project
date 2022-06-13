#Part: xc7z020clg484-1
#ZedBoard Zynq Evaluation and Development Kit

set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN F22 [get_ports reset_n]; # SW0
set_property IOSTANDARD LVCMOS33 [get_ports reset_n];

# INPUT
set_property PACKAGE_PIN N15 [get_ports sensor1]; # BTNL
set_property PACKAGE_PIN P16 [get_ports sensor2]; # BTNC
set_property PACKAGE_PIN R18 [get_ports sensor3]; # BTNR
set_property PACKAGE_PIN T18 [get_ports valid_Epass]; # BTNU
set_property PACKAGE_PIN G22 [get_ports enable]; # SW1

set_property IOSTANDARD LVCMOS33 [get_ports sensor1]; # BTNL
set_property IOSTANDARD LVCMOS33 [get_ports sensor2]; # BTNC
set_property IOSTANDARD LVCMOS33 [get_ports sensor3]; # BTNR
set_property IOSTANDARD LVCMOS33 [get_ports valid_Epass]; # BTNU
set_property IOSTANDARD LVCMOS33 [get_ports enable]; # SW1

# OUTPUT
set_property PACKAGE_PIN Y11 [get_ports barrier]; # JA1
set_property PACKAGE_PIN AA11 [get_ports serial_data_out]; # JA2

set_property IOSTANDARD LVCMOS33 [get_ports barrier]; # JA1
set_property IOSTANDARD LVCMOS33 [get_ports serial_data_out]; # JA2
#set_property DRIVE 8 [get_ports uart_txd];