//----------------------------------- storing-data-in module----------------------------------------------------------

// this module gets the data in bytes form @ the clk edges 
// and  stores it in 4 32bit-word memory 
// and provides 4 buses, each helding  the data of  one word


module byteTOmatrix (clk, rst, byte_in, out0, out1, out2, out3);
  parameter words_num = 4;
  input          clk, rst;
  input  [7:0]  byte_in;
  //output reg [127:0] out_keys; 
  output reg [31:0] out0, out1, out2, out3; 
 
  reg   [31:0]  in_reg;
  reg   [2:0]   sel_ctr;
  reg   [words_num-1:0]  mem_word_ctr;
  reg   [31:0]  matrix_mem [0:words_num-1];

//selector counter of the position of the input register the data byte getting in
  always @ (posedge clk) begin
    if(rst)
    sel_ctr <= 0;
    else if (sel_ctr ==3'b100)
    sel_ctr <=1;
    else  
    sel_ctr <= sel_ctr + 1;
    
  end//always

//getting data in input register
  always @ (negedge clk)
  begin
    if (rst)
    begin
    in_reg <=0;
    mem_word_ctr <= 0;
    end//if
    else    
    begin
    case (sel_ctr)
    3'b001: in_reg[31:0] <= {byte_in, in_reg[23:0]};
    3'b010: in_reg[31:0] <= {in_reg[31:24], byte_in, in_reg[15:0]};
    3'b011: in_reg[31:0] <= {in_reg[31:16], byte_in, in_reg[7:0]};
    3'b100: in_reg[31:0] <= {in_reg[31:8], byte_in};
    endcase
    end//else
  end//always


  integer i;
  //shifting daata to the memory
  always @ (posedge clk)
  begin
  if (sel_ctr == 3'b100)
  begin
  matrix_mem [0] <= in_reg;
  for(i=1; i<=words_num-1; i = i + 1)
  begin        
  matrix_mem[i] <= matrix_mem[i-1];
  end//for
  mem_word_ctr <= mem_word_ctr + 1;
  end//if
  end//always 
  
  //wiring memory data to output ports
  always @ *
  begin
    out3 = matrix_mem [0];
    out2 = matrix_mem [1]; 
    out1 = matrix_mem [2]; 
    out0 = matrix_mem [3];
  end//always
endmodule



//forcing
/*

force -freeze sim:/byteTOmatrix/byte_in 11 0
force -freeze sim:/byteTOmatrix/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/byteTOmatrix/rst 1 0
run
force -freeze sim:/byteTOmatrix/rst 0 0
run
force -freeze sim:/byteTOmatrix/byte_in 100 0
run
run
run
run
run
force -freeze sim:/byteTOmatrix/byte_in 1 0
run
run
run
force -freeze sim:/byteTOmatrix/byte_in 10 0
run
run
run
run
run

*/