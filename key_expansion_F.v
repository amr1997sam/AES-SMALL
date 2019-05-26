`timescale 1ns / 1ps

module key_schedule (key_in0, key_in1, key_in2, key_in3, clk, first_data_in_flag, key_flag,
                     round, key_out0, key_out1, key_out2, key_out3);
//ports
input first_data_in_flag, clk;
input      [31:0] key_in0, key_in1, key_in2, key_in3; 

output reg [3:0]  round;// needed outside this module
output reg key_flag;
output reg   [31:0] key_out0, key_out1, key_out2, key_out3; 

//nets
reg [1:0]   row;
reg [7:0]   r_con;
reg [31:0]  R_con;
reg [31:0]  to_rot_row;
reg [31:0]  roted_row;
reg [31:0] XORout;
wire [31:0] subed;

//---------------------------------------------R constant ------------------------------------------------------
parameter r_con12 = 24'b000000000000000000000000 ;
parameter r_con91 = 8'b00011011; //1b
parameter r_con01 = 8'b00110110; //36
parameter r_con1  = 8'b00000001;  //01

always @*
begin
  if (round!=1 && round!=9 && round!=10)
  r_con[7:0] = {r_con[6:0], r_con[7]};
  else if (round==9)
  r_con[7:0] = r_con91;
  else if (round == 10)
  r_con[7:0] = r_con01;
  else if (round==1)
  r_con[7:0] = r_con1;
  
  //R_con = {r_con12,r_con[7:0]};
  R_con = {r_con[7:0], r_con12};
end//always


//--------------------------------------------  matrix -------------------------------------------------------
reg   [31:0]  matrix_mem [0:7];

//--------------------------------------------  rotation -------------------------------------------------------
always @*
begin
  to_rot_row = matrix_mem[3];
  //roted_row = {to_rot_row[7:0] , to_rot_row[31:8]};
  roted_row = {to_rot_row[23:0] , to_rot_row[31:24]};
end//always 

//--------------------------------------------  sub bytes -------------------------------------------------------
KeySubBytes sbox (roted_row, subed);

//------------------------------------------ XORing ---------------------------------------------------------
always @*
begin
  if (row == 0)
  XORout = R_con ^ subed ^ matrix_mem[0];
  else  
  XORout = matrix_mem[row] ^ matrix_mem[row+3];
end//always

//--------------------------------------------  state & memory -----------------------------------------------------------
always @ (posedge clk, posedge first_data_in_flag)
begin
  //resetting
  if (first_data_in_flag)
  begin
  round <= 1; //10 rounds
  row <= 0; // 4 rows
  matrix_mem[0] <= key_in0;
  matrix_mem[1] <= key_in1;
  matrix_mem[2] <= key_in2;
  matrix_mem[3] <= key_in3;
  key_flag <=0;
  end//if first_data_in_flag
  else
  //operation
  begin
  //----------------------------------
  if (round < 10)
  begin
   if (row < 3)//---------------------
   begin
   key_flag <=0;
   matrix_mem [row+4] <= XORout;
   row <= row + 1;
   end
   else if (row ==3)//---------------
   begin
   matrix_mem[0] <=   matrix_mem[4];
   matrix_mem[1] <=   matrix_mem[5];
   matrix_mem[2] <=   matrix_mem[6];
   matrix_mem[3] <=   XORout;
   matrix_mem[7] <=   XORout;
   key_flag <=1;
   round <= round +1;
   row <= row + 1;
   end// round<10, row==3
  end//if round<10
  //---------------------------------
  else if (round == 10)
   if (row < 3)//--------------------
   begin
   matrix_mem [row+4] <= XORout;
   row <= row + 1;
   key_flag <= 0;
   end
   else if (row==3)//----------------
   begin
   round <=1;
   row=0;
   matrix_mem[0] <= key_in0;
   matrix_mem[1] <= key_in1;
   matrix_mem[2] <= key_in2;
   matrix_mem[3] <= key_in3;
   matrix_mem[7] <= XORout;
   key_flag <= 1;
   end//round==10, row==3
  end//else data_in_flag
end//always
//----------------------------------------------output wires ----------------------------------------------------
always @*
begin
  key_out0 = matrix_mem[4]; 
  key_out1 = matrix_mem[5]; 
  key_out2 = matrix_mem[6];
  key_out3 = matrix_mem[7];
end

endmodule


//////////////////////////////////////////////////////////////////////////////////testbench
/*
module key_exp_test;
  wire  [3:0] round; 
  wire  [31:0] key_out0, key_out1, key_out2, key_out3;
  
  wire key_flag;
  reg   [31:0] key_in0, key_in1, key_in2, key_in3;
  reg clk, first_data_in_flag;
  
  key_schedule dut (key_in0, key_in1, key_in2, key_in3, clk, first_data_in_flag, key_flag,
                     round, key_out0, key_out1, key_out2, key_out3);
                    
initial
begin
  //clock
  forever begin clk<=1; #0.05; clk<=0; #0.05; end
end
    
initial
begin   
  //reset
  first_data_in_flag <= 1; #0.05; first_data_in_flag <= 0;
  //inputs
end
  
initial 
begin
  key_in0 = 32'h2b7e1516;
  key_in1 = 32'h28aed2a6;
  key_in2 = 32'habf71588 ;
  key_in3 = 32'h09cf4f3c;
end
  //00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
  //  0f 0e 0d 0c  0b 0a 09 08  07 06 05 04  03 02 01 00                
//out//1st round key// fe76abd6f178a6dafa72afd2fd74aad6 

                     
                     
endmodule
*/