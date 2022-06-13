//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
//Date        : Mon Jun 13 15:06:38 2022
//Host        : dt25-linux running 64-bit CentOS Linux release 7.9.2009 (Core)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,da_clkrst_cnt=1,synth_mode=Global}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (barrier,
    clk,
    enable,
    reset_n,
    sensor1,
    sensor2,
    sensor3,
    serial_data_out,
    valid_Epass);
  output barrier;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN design_1_clk_in1_0, FREQ_HZ 100000000, PHASE 0.000" *) input clk;
  input enable;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_N RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_N, POLARITY ACTIVE_LOW" *) input reset_n;
  input sensor1;
  input sensor2;
  input sensor3;
  output serial_data_out;
  input valid_Epass;

  wire clk_in1_0_1;
  wire clk_wiz_0_clk_out1;
  wire enable_1;
  wire reset_n_1;
  wire sensor1_1;
  wire sensor2_1;
  wire sensor3_1;
  wire top_0_barrier;
  wire top_0_serial_data_out;
  wire valid_Epass_1;

  assign barrier = top_0_barrier;
  assign clk_in1_0_1 = clk;
  assign enable_1 = enable;
  assign reset_n_1 = reset_n;
  assign sensor1_1 = sensor1;
  assign sensor2_1 = sensor2;
  assign sensor3_1 = sensor3;
  assign serial_data_out = top_0_serial_data_out;
  assign valid_Epass_1 = valid_Epass;
  design_1_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_in1_0_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .resetn(reset_n_1));
  design_1_top_0_0 top_0
       (.barrier(top_0_barrier),
        .clk(clk_wiz_0_clk_out1),
        .enable(enable_1),
        .reset_n(reset_n_1),
        .sensor1(sensor1_1),
        .sensor2(sensor2_1),
        .sensor3(sensor3_1),
        .serial_data_out(top_0_serial_data_out),
        .valid_Epass(valid_Epass_1));
endmodule
