// (c) Copyright 1995-2022 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:non_stop_ETC:1.0
// IP Revision: 1

(* X_CORE_INFO = "non_stop_ETC,Vivado 2018.1" *)
(* CHECK_LICENSE_TYPE = "design_1_non_stop_ETC_0_2,non_stop_ETC,{}" *)
(* CORE_GENERATION_INFO = "design_1_non_stop_ETC_0_2,non_stop_ETC,{x_ipProduct=Vivado 2018.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=non_stop_ETC,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,WIDTH_TIK=16,WIDTH_MS=14,WIDTH_SPEED=14,SYS_FREQ=10000000}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_non_stop_ETC_0_2 (
  clk,
  reset_n,
  sensor1,
  sensor2,
  sensor3,
  valid_Epass,
  enable,
  led1,
  led2,
  led3,
  led4,
  led5,
  led6,
  done_speed,
  barrier
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 10000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_n RST" *)
input wire reset_n;
input wire sensor1;
input wire sensor2;
input wire sensor3;
input wire [1 : 0] valid_Epass;
input wire enable;
output wire led1;
output wire led2;
output wire led3;
output wire led4;
output wire led5;
output wire led6;
output wire [14 : 0] done_speed;
output wire barrier;

  non_stop_ETC #(
    .WIDTH_TIK(16),
    .WIDTH_MS(14),
    .WIDTH_SPEED(14),
    .SYS_FREQ(10000000)
  ) inst (
    .clk(clk),
    .reset_n(reset_n),
    .sensor1(sensor1),
    .sensor2(sensor2),
    .sensor3(sensor3),
    .valid_Epass(valid_Epass),
    .enable(enable),
    .led1(led1),
    .led2(led2),
    .led3(led3),
    .led4(led4),
    .led5(led5),
    .led6(led6),
    .done_speed(done_speed),
    .barrier(barrier)
  );
endmodule
