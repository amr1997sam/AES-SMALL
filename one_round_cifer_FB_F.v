module one_round_cifer_FB(clk, round,key_flag, a,b,c,d,k1,k2,k3,k4,x,y,z,w);
  
  //connections
  input clk, key_flag;
  input [3:0] round;
  
  input  [31:0] a,b,c,d;  
  
  input [31:0] k1,k2,k3,k4;
  
  output [31:0] x,y,z,w;
  
  // output of mux - input of sub_top (cycle)
  wire [31:0] mux_o1,mux_o2,mux_o3,mux_o4;  
  
  //register to save cifer block output
  reg [31:0] fb0,fb1,fb2,fb3;

wire [31:0] xj,yj,zj,wj;
  
mux selector (key_flag, round, a, b, c, d, fb0, fb1, fb2, fb3, mux_o1, mux_o2, mux_o3, mux_o4);

one_round_cifer cycle (clk,key_flag, round,mux_o1,mux_o2,mux_o3,mux_o4,k1,k2,k3,k4,xj,yj,zj,wj);
  
  
  always@(negedge clk)
begin
  if (key_flag)
    begin
    fb0 <= xj;
    fb1 <= yj;
    fb2 <= zj;
    fb3 <= wj;
  end
end 

assign x=xj; 
assign y=yj;
assign z=zj;
assign w=wj;
endmodule

/////////////////////////////////////////////////////////////////////////////////////////testbench
/*
 module one_round_cifer_fb_test;
   reg  [3:0]     round;
   reg  [31:0]    cipher_data0,cipher_data1,cipher_data2,cipher_data3,
              cipher_key0,cipher_key1,cipher_key2,cipher_key3;
   reg clk, key_flag;           
   wire [31:0]   x,y,z,w;
   
   one_round_cifer_FB dut(clk, round, key_flag, cipher_data0,cipher_data1,cipher_data2,cipher_data3,
              	           cipher_key0,cipher_key1,cipher_key2,cipher_key3,x,y,z,w);
   

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
//ffeeddcc bbaa9988 77665544 33221100

endmodule
*/
////////////////////////////////////////////////////////////////forcing

/*

force -freeze sim:/one_round_cifer_FB/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/one_round_cifer_FB/round 1 0
force -freeze sim:/one_round_cifer_FB/key_flag 0 0
force -freeze sim:/one_round_cifer_FB/a 32'h19a09ae9 0
force -freeze sim:/one_round_cifer_FB/b 32'h3df4c6f8 0
force -freeze sim:/one_round_cifer_FB/c 32'he3e28d48 0
force -freeze sim:/one_round_cifer_FB/d 32'hbe2b2a08 0

force -freeze sim:/one_round_cifer_FB/k1 32'ha088232a 0
run
force -freeze sim:/one_round_cifer_FB/k2 32'hfa54a36c 0
run
force -freeze sim:/one_round_cifer_FB/k3 32'hfe2c3976 0
run
force -freeze sim:/one_round_cifer_FB/k4 32'h17b13905 0
force -freeze sim:/one_round_cifer_FB/key_flag 1 0
force -freeze sim:/one_round_cifer_FB/round 10 0
run
force -freeze sim:/one_round_cifer_FB/key_flag 0 0
force -freeze sim:/one_round_cifer_FB/k1 32'hf27a5973 0
run
force -freeze sim:/one_round_cifer_FB/k2 32'hc2963559 0
run
force -freeze sim:/one_round_cifer_FB/k3 32'h95b980f6 0
run
force -freeze sim:/one_round_cifer_FB/k4 32'hf2437a7f 0
force -freeze sim:/one_round_cifer_FB/key_flag 1 0
force -freeze sim:/one_round_cifer_FB/round 11 0

run
force -freeze sim:/one_round_cifer_FB/key_flag 0 0
force -freeze sim:/one_round_cifer_FB/k1 32'h3d471e6d 0
run
force -freeze sim:/one_round_cifer_FB/k2 32'h8016237a 0
run
force -freeze sim:/one_round_cifer_FB/k3 32'h47fe7e88 0
run
force -freeze sim:/one_round_cifer_FB/k4 32'h7d3e443b 0
force -freeze sim:/one_round_cifer_FB/key_flag 1 0
force -freeze sim:/one_round_cifer_FB/round 100 0
run
force -freeze sim:/one_round_cifer_FB/key_flag 0 0
force -freeze sim:/one_round_cifer_FB/k1 32'hefa8b6db 0
run
force -freeze sim:/one_round_cifer_FB/k2 32'h4452710b 0
run
force -freeze sim:/one_round_cifer_FB/k3 32'ha55b25ad 0
run
force -freeze sim:/one_round_cifer_FB/k4 32'h417f3b00 0
force -freeze sim:/one_round_cifer_FB/key_flag 1 0
force -freeze sim:/one_round_cifer_FB/round 101 0
run
force -freeze sim:/one_round_cifer_FB/key_flag 0 0
force -freeze sim:/one_round_cifer_FB/k1 32'hd47cca11 0
run
force -freeze sim:/one_round_cifer_FB/k2 32'hd183f2f9 0
run
force -freeze sim:/one_round_cifer_FB/k3 32'hc69db815 0
run
force -freeze sim:/one_round_cifer_FB/k4 32'hf887bcbc 0
force -freeze sim:/one_round_cifer_FB/key_flag 1 0
force -freeze sim:/one_round_cifer_FB/round 110 0
run

*/
 

