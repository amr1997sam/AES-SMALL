module out (clk, rst, state0, state1, state2, state3, enc, out0, out1, out2, out3);
  input   [31:0] state0, state1, state2, state3; 
  output reg [31:0] out0, out1, out2, out3;
  input  clk, rst;
  input  [5:0] enc;
  
  always @ (negedge clk)
  begin
  if (rst)
  begin
  out0 <= 0; 
  out1 <= 0;
  out2 <= 0;
  out3 <= 0;
  end//if rst
  else
  if (enc ==18)
  begin
  out0 <= state0; 
  out1 <= state1;
  out2 <= state2;
  out3 <= state3;
  end//else rst
  end//always
endmodule