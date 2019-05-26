/*
-------------------ADD ROUND MODULE---------------------

The INPUT...
* 4*4 matrix enters in 4 wires a,b,c,d ...EVERY WIRE REPRESENTS A ROW
* 4*4 matrix(key) enters in 4 wires k1,k2,k3,k4 ...EVERY WIRE REPRESENTS A ROW
The OUTPUT is 4*4 matrix enters in 4 wires x,y,z,w ...EVERY WIRE REPRESENTS A ROW
*/
module add_round_key (a,b,c,d,k1,k2,k3,k4,x,y,z,w);
//input state matrix  
  input [31:0] a;
  input [31:0] b;
  input [31:0] c;
  input [31:0] d;
//key matrix  
  input [31:0] k1;
  input [31:0] k2;
  input [31:0] k3;
  input [31:0] k4;
//output state matrix
  output [31:0] x;
  output [31:0] y;
  output [31:0] z;
  output [31:0] w;
// the output state matrix = the input state matix (XOR) the round key...   
  assign x=a^k1;
  assign y=b^k2;
  assign z=c^k3;
  assign w=d^k4;
  
endmodule
/*
module add_round_key_test;
   
   reg  [31:0]    cipher_data0,cipher_data1,cipher_data2,cipher_data3,
              cipher_key0,cipher_key1,cipher_key2,cipher_key3;
   wire [31:0]   x,y,z,w;
   
   add_round_key dut(cipher_data0,cipher_data1,cipher_data2,cipher_data3,
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