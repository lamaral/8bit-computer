// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (win64) Build 2580384 Sat Jun 29 08:12:21 MDT 2019
// Date        : Sat Aug 17 01:14:20 2019
// Host        : DESKTOP-8G573J6 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Luiz/Documents/Vivado/Test/Test/Test.srcs/sources_1/ip/ram_memory/ram_memory_stub.v
// Design      : ram_memory
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1.1" *)
module ram_memory(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[3:0],dina[7:0],clkb,addrb[3:0],doutb[7:0]" */;
  input clka;
  input [0:0]wea;
  input [3:0]addra;
  input [7:0]dina;
  input clkb;
  input [3:0]addrb;
  output [7:0]doutb;
endmodule
