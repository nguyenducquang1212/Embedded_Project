//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
//Date        : Tue Jun 14 09:43:24 2022
//Host        : dt25-linux running 64-bit CentOS Linux release 7.9.2009 (Core)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (barrier,
    clk,
    enable,
    led1,
    led2,
    led3,
    reset_n,
    sensor1,
    sensor2,
    sensor3,
    serial_data_out,
    valid_Epass);
  output barrier;
  input clk;
  input enable;
  output led1;
  output led2;
  output led3;
  input reset_n;
  input sensor1;
  input sensor2;
  input sensor3;
  output serial_data_out;
  input [1:0]valid_Epass;

  wire barrier;
  wire clk;
  wire enable;
  wire led1;
  wire led2;
  wire led3;
  wire reset_n;
  wire sensor1;
  wire sensor2;
  wire sensor3;
  wire serial_data_out;
  wire [1:0]valid_Epass;

  design_1 design_1_i
       (.barrier(barrier),
        .clk(clk),
        .enable(enable),
        .led1(led1),
        .led2(led2),
        .led3(led3),
        .reset_n(reset_n),
        .sensor1(sensor1),
        .sensor2(sensor2),
        .sensor3(sensor3),
        .serial_data_out(serial_data_out),
        .valid_Epass(valid_Epass));
endmodule
