module one_round_cifer (clk,key_flag, count,a,b,c,d,q1,q2,q3,q4,x,y,z,w);
  input clk, key_flag;
  input [3:0] count;
  
//INPUTS  
  input [31:0] a; //initial state -after the first add round- input of subbyte
  input [31:0] b;
  input [31:0] c;
  input [31:0] d;
  
//key expansion matrix
  input [31:0] q1; //key after expansion - used in the cycle after the 1st add round-
  input [31:0] q2;
  input [31:0] q3;
  input [31:0] q4;
  
//OUTPUTS
  output  [31:0] x; //sub_top outputs
  output  [31:0] y;
  output  [31:0] z;
  output  [31:0] w; 
  
//wires
  wire[31:0] x1,y1,z1,w1; //sub byte output -shift rows input 
  wire [31:0] a1,b1,c1,d1; //shift rows output - mix colomns input   
  wire [31:0] a3,b3,c3,d3; // mix colomns output 
  
  
  
//reg
  reg [31:0] ad1,ad2,ad3,ad4 ; //add round input
  //reg toggle;
  
  SubBytes sub_byte (a,b,c,d,x1,y1,z1,w1);
            
  shift_rows shiftrows (x1,y1,z1,w1,a1,b1,c1,d1);
            
  mix_columns mixcolumns (a1,b1,c1,d1,a3,b3,c3,d3);
         
  add_round_key addroundkey (ad1,ad2,ad3,ad4,q1,q2,q3,q4,x,y,z,w);
/*           
Always@(posedge clk)
Begin
If(count==10 & flag==0)
    toggle <= 1;
  else
    toggle <=0;
end
  */
always@(posedge clk)
begin
if(count==10 & key_flag==0)
    begin
    ad1=a1;
    ad2=b1;
    ad3=c1;
    ad4=d1; 
     end
  else
  begin
    ad1=a3;
    ad2=b3;
    ad3=c3;
    ad4=d3;
    end

end          
    
 endmodule
 
 
 
/////////////////////////////////////////////////////////////////////////////////// //testbench
/* module one_round_cifer_test;
   reg  [3:0]     round;
   reg  [31:0]    cipher_data0,cipher_data1,cipher_data2,cipher_data3,
              cipher_key0,cipher_key1,cipher_key2,cipher_key3;
   wire [31:0]   x,y,z,w;
   
   one_round_cifer dut(round,cipher_data0,cipher_data1,cipher_data2,cipher_data3,
              	           cipher_key0,cipher_key1,cipher_key2,cipher_key3,x,y,z,w);
   

//inputs
//key
initial 
begin
  //d6aa74fdd2af72fadaa678f1d6ab76fe
  cipher_key0 = 32'hd6d2dad6;
  cipher_key1 = 32'haaafa6ab;
  cipher_key2 = 32'h74727876;
  cipher_key3 = 32'hfdfaf1fe;
end            

//cifer data
initial 
begin
  //00102030405060708090a0b0c0d0e0f0
  cipher_data0 = 32'h004488cc;
  cipher_data1 = 32'h115599dd;
  cipher_data2 = 32'h2266aaee;
  cipher_data3 = 32'h3377bbff;
end            
//ffeeddcc bbaa9988 77665544 33221100

endmodule
*/