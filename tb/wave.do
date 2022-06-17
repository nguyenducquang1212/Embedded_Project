onerror {resume}
quietly virtual signal -install /top_tb/DUT { /top_tb/DUT/speed[13:4]} speed_int
quietly virtual signal -install /top_tb/DUT { /top_tb/DUT/speed[3:0]} speed_real
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /top_tb/DUT/clk
add wave -noupdate -radix unsigned /top_tb/DUT/reset_n
add wave -noupdate -radix unsigned /top_tb/DUT/sensor1
add wave -noupdate -radix unsigned /top_tb/DUT/sensor2
add wave -noupdate -radix unsigned /top_tb/DUT/sensor3
add wave -noupdate -radix unsigned /top_tb/DUT/enable
add wave -noupdate -color Yellow -radix unsigned /top_tb/DUT/valid_Epass
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/up
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/down
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/en
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/dis
add wave -noupdate -radix unsigned /top_tb/DUT/done
add wave -noupdate -color Coral -radix unsigned /top_tb/DUT/barrier
add wave -noupdate -radix binary -childformat {{{/top_tb/DUT/speed[13]} -radix unsigned} {{/top_tb/DUT/speed[12]} -radix unsigned} {{/top_tb/DUT/speed[11]} -radix unsigned} {{/top_tb/DUT/speed[10]} -radix unsigned} {{/top_tb/DUT/speed[9]} -radix unsigned} {{/top_tb/DUT/speed[8]} -radix unsigned} {{/top_tb/DUT/speed[7]} -radix unsigned} {{/top_tb/DUT/speed[6]} -radix unsigned} {{/top_tb/DUT/speed[5]} -radix unsigned} {{/top_tb/DUT/speed[4]} -radix unsigned} {{/top_tb/DUT/speed[3]} -radix unsigned} {{/top_tb/DUT/speed[2]} -radix unsigned} {{/top_tb/DUT/speed[1]} -radix unsigned} {{/top_tb/DUT/speed[0]} -radix unsigned}} -subitemconfig {{/top_tb/DUT/speed[13]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[12]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[11]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[10]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[9]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[8]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[7]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[6]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[5]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[4]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[3]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[2]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[1]} {-height 17 -radix unsigned} {/top_tb/DUT/speed[0]} {-height 17 -radix unsigned}} /top_tb/DUT/speed
add wave -noupdate -radix unsigned /top_tb/DUT/clock
add wave -noupdate -color Yellow -radix unsigned /top_tb/DUT/serial_data_out
add wave -noupdate -radix unsigned /top_tb/DUT/tx_done
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/car1
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/car2
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/car3
add wave -noupdate -radix unsigned /top_tb/DUT/speed_int
add wave -noupdate -radix binary /top_tb/DUT/speed_real
add wave -noupdate -radix unsigned /top_tb/DUT/data
add wave -noupdate -radix unsigned /top_tb/DUT/write
add wave -noupdate -radix unsigned /top_tb/DUT/sample_clk
add wave -noupdate -radix unsigned /top_tb/DUT/tx_data_in
add wave -noupdate -radix unsigned /top_tb/DUT/tx_full
add wave -noupdate -radix unsigned /top_tb/DUT/tx_empty
add wave -noupdate -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/time_ms
add wave -noupdate -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/time_tik
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/next_state
add wave -noupdate /top_tb/DUT/non_stop_ETC/cotroller_DUT/current_state
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/clk
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/reset_n
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/dividend
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/divisor
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/sen1
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/sen2
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/Q
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/done
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/X
add wave -noupdate -group div -color Yellow -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/Y
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/A
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/count
add wave -noupdate -group div -radix unsigned /top_tb/DUT/non_stop_ETC/datapath_DUT/div_DUT/minus
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/clk
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/reset_n
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/sensor1
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/sensor2
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/sensor3
add wave -noupdate -group Controller -expand /top_tb/DUT/non_stop_ETC/cotroller_DUT/valid_Epass
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/enable
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/num_veh
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/done
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/init
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/count
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/cal
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/up
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/down
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/en
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/dis
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/reg_sensor3
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/next_state
add wave -noupdate -group Controller /top_tb/DUT/non_stop_ETC/cotroller_DUT/current_state
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/HOLD
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/INC
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/clk
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/reset_n
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/sensor1
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/sensor2
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/sensor3
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/inc1
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/car1
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/inc2
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/car2
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/inc3
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/car3
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/next_state_c1
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/current_state_c1
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/next_state_c3
add wave -noupdate -group COUNT_CAR /top_tb/DUT/non_stop_ETC/cotroller_DUT/count_car_DUT/current_state_c3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31054255 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 343
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {65835021 ns}
