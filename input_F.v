module input_control (clk, rst, byte_in, O_bus0, O_bus1, O_bus2 , O_bus3, load, key_rst,  enc);
    input clk,rst;
    input [7:0] byte_in;
    output load, key_rst;
    output [31:0] O_bus0, O_bus1, O_bus2, O_bus3;
    output [5:0] enc;
    
    wire [31:0] out0,out1,out2,out3;
      byteTOmatrix bytetomatrix  (clk, rst, byte_in, out0, out1, out2, out3);
      in_fetch_timing infetchtiming (clk,rst,out0,out1,out2,out3,O_bus0,O_bus1,O_bus2,O_bus3,load,key_rst, enc);
endmodule
