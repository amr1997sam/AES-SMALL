`timescale 1ps / 1ps
module top_module_1 ( 
 cipher_data0 ,
 cipher_data1 ,
 cipher_data2 ,
 cipher_data3 ,
 cipher_key0  ,
 cipher_key1  ,
 cipher_key2  ,
 cipher_key3  ,
 clk          ,
 rst          ,
 cipher_text0 ,
 cipher_text1 ,
 cipher_text2 ,
 cipher_text3
             );
//INPUTS  
input [31:0] cipher_data0;
input [31:0] cipher_data1;
input [31:0] cipher_data2;
input [31:0] cipher_data3; 
input [31:0] cipher_key0;
input [31:0] cipher_key1;
input [31:0] cipher_key2;
input [31:0] cipher_key3;

input clk;
input rst;
//OUTPUTS

output  [31:0] cipher_text0;
output  [31:0] cipher_text1;
output  [31:0] cipher_text2;
output  [31:0] cipher_text3; 

wire [31:0] first_round_0;
wire [31:0] first_round_1;
wire [31:0] first_round_2;
wire [31:0] first_round_3;

wire [3:0] round;
wire key_flag;

wire [31:0] key_out0; 
wire [31:0] key_out1;
wire [31:0] key_out2; 
wire [31:0] key_out3;
wire [31:0] c_d1,c_d2,c_d3,c_d4;
wire [31:0] c_k1,c_k2,c_k3,c_k4;
wire [31:0] s_k0, s_k1, s_k2, s_k3;

trans trnsp_cifer (cipher_data0, cipher_data1, cipher_data2, cipher_data3, c_d1, c_d2, c_d3, c_d4);

trans trnsp_1stKey (cipher_key0, cipher_key1, cipher_key2, cipher_key3, c_k1, c_k2, c_k3, c_k4);

add_round_key add_round_1 (c_d1,c_d2,c_d3,c_d4,
                            c_k1,c_k2,c_k3,c_k4,
                            first_round_0,first_round_1,first_round_2,first_round_3);

key_schedule key_exp (cipher_key0, cipher_key1, cipher_key2, cipher_key3, 
                     clk, rst, key_flag,
                     round, key_out0, key_out1, key_out2, key_out3);
                     
trans trnsp_subKey (key_out0, key_out1, key_out2, key_out3, s_k0, s_k1, s_k2, s_k3);
                     
one_round_cifer_FB all_rounds (clk, round,key_flag, first_round_0,first_round_1,first_round_2,first_round_3,
                      s_k0, s_k1, s_k2, s_k3,
                      cipher_text0,cipher_text1,cipher_text2,cipher_text3);
    
endmodule
/*
module top_module_1_test;
 reg [31:0] cipher_data0 ,
 cipher_data1 ,
 cipher_data2 ,
 cipher_data3 ,
 cipher_key0  ,
 cipher_key1  ,
 cipher_key2  ,
 cipher_key3  ;
 reg clk      ,
 rst          ;
wire [31:0] cipher_text0 ,
 cipher_text1 ,
 cipher_text2 ,
 cipher_text3 ;
  
  top_module_1 dut ( 
 cipher_data0 ,
 cipher_data1 ,
 cipher_data2 ,
 cipher_data3 ,
 cipher_key0  ,
 cipher_key1  ,
 cipher_key2  ,
 cipher_key3  ,
 clk          ,
 rst          ,
 cipher_text0 ,
 cipher_text1 ,
 cipher_text2 ,
 cipher_text3
             );
             
initial
begin
  //clock
  forever begin clk<=1; #50; clk<=0; #50; end
end
    
initial
begin   
  //reset
  rst <= 1; #50; rst <= 0;
end

//inputs
//key
initial 
begin
  cipher_key0 = 32'h03020100;
  cipher_key1 = 32'h07060504;
  cipher_key2 = 32'h0b0a0908;
  cipher_key3 = 32'h0f0e0d0c;
end            

//cifer data
initial 
begin
  cipher_data0 = 32'h33221100;
  cipher_data1 = 32'h77665544;
  cipher_data2 = 32'hbbaa9988;
  cipher_data3 = 32'hffeeddcc;
end            


endmodule
*/
//forcing
/*

force -freeze sim:/top_module_1/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/top_module_1/rst 1 0
force -freeze sim:/top_module_1/cipher_data0 32'h3243f6a8 0
force -freeze sim:/top_module_1/cipher_data1 32'h885a308d 0
force -freeze sim:/top_module_1/cipher_data2 32'h313198a2 0
force -freeze sim:/top_module_1/cipher_data3 32'he0370734 0
force -freeze sim:/top_module_1/cipher_key0 32'h2b7e1516 0
force -freeze sim:/top_module_1/cipher_key1 32'h28aed2a6 0
force -freeze sim:/top_module_1/cipher_key2 32'habf71588 0
force -freeze sim:/top_module_1/cipher_key3 32'h09cf4f3c 0
run
force -freeze sim:/top_module_1/rst 0 0
run

*/