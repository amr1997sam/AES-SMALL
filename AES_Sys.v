module AES_SYS (clk, rst, data_in, key_in, load, ctext0,ctext1,ctext2,ctext3);
  input clk,rst;
  output load;
  output [31:0] ctext0,ctext1,ctext2,ctext3;
  input [7:0] data_in, key_in;
  wire [31:0] out0, out1, out2, out3;
  wire [31:0] cipher_text0, cipher_text1, cipher_text2, cipher_text3;
  wire [127:0]nonce;
  wire [31:0] cipher_key0, cipher_key1, cipher_key2 , cipher_key3, cipher_data0, cipher_data1, cipher_data2 , cipher_data3;
  wire [5:0] enc;
input_control datain (clk, rst, data_in, cipher_data0, cipher_data1, cipher_data2 , cipher_data3, load,,  enc);

input_control keyin (clk, rst, key_in, cipher_key0, cipher_key1, cipher_key2 , cipher_key3, , key_rst,);

top_module_1 subtop ( 
 nonce [127:96] ,
 nonce [95:64] ,
 nonce [63:32],
 nonce[31:0] ,
 cipher_key0  ,
 cipher_key1  ,
 cipher_key2  ,
 cipher_key3  ,
 clk          ,
 key_rst      ,
 cipher_text0 ,
 cipher_text1 ,
 cipher_text2 ,
 cipher_text3
             );
out outCifer (clk,  rst, cipher_text0, cipher_text1, cipher_text2, cipher_text3,  enc, out0, out1, out2, out3);             
 
 int nonc (rst,nonce,cipher_key0,cipher_key1,cipher_key2,cipher_key3,enc);
 
 last xoring (cipher_data0, cipher_data1, cipher_data2 , cipher_data3,out0, out1, out2, out3,{ctext0,ctext1,ctext2,ctext3});
 
endmodule

//forcing
/*

force -freeze sim:/AES_SYS/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/AES_SYS/rst 1 0
run
run
force -freeze sim:/AES_SYS/rst 0 0
run
force -freeze sim:/AES_SYS/data_in 8'h32 0
force -freeze sim:/AES_SYS/key_in 8'h2b 0
run
force -freeze sim:/AES_SYS/data_in 8'h43 0
force -freeze sim:/AES_SYS/key_in 8'h7e 0
run
force -freeze sim:/AES_SYS/data_in 8'hf6 0
force -freeze sim:/AES_SYS/key_in 8'h15 0
run
force -freeze sim:/AES_SYS/data_in 8'ha8 0
force -freeze sim:/AES_SYS/key_in 8'h16 0
run
force -freeze sim:/AES_SYS/data_in 8'h88 0
force -freeze sim:/AES_SYS/key_in 8'h28 0
run
force -freeze sim:/AES_SYS/data_in 8'h5a 0
force -freeze sim:/AES_SYS/key_in 8'hae 0
run
force -freeze sim:/AES_SYS/data_in 8'h30 0
force -freeze sim:/AES_SYS/key_in 8'hd2 0
run
force -freeze sim:/AES_SYS/data_in 8'h8d 0
force -freeze sim:/AES_SYS/key_in 8'ha6 0
run
force -freeze sim:/AES_SYS/data_in 8'h31 0
force -freeze sim:/AES_SYS/key_in 8'hab 0
run
force -freeze sim:/AES_SYS/data_in 8'h31 0
force -freeze sim:/AES_SYS/key_in 8'hf7 0
run
force -freeze sim:/AES_SYS/data_in 8'h98 0
force -freeze sim:/AES_SYS/key_in 8'h15 0
run
force -freeze sim:/AES_SYS/data_in 8'ha2 0
force -freeze sim:/AES_SYS/key_in 8'h88 0
run
force -freeze sim:/AES_SYS/data_in 8'he0 0
force -freeze sim:/AES_SYS/key_in 8'h09 0
run
force -freeze sim:/AES_SYS/data_in 8'h37 0
force -freeze sim:/AES_SYS/key_in 8'hcf 0
run
force -freeze sim:/AES_SYS/data_in 8'h07 0
force -freeze sim:/AES_SYS/key_in 8'h4f 0
run
force -freeze sim:/AES_SYS/data_in 8'h34 0
force -freeze sim:/AES_SYS/key_in 8'h3c 0
run


*/
