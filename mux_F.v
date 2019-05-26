module mux (key_flag, count, a, b, c, d, a1, b1, c1, d1, x, y, z, w) ;
input key_flag;
input [3:0] count ;
input [31:0] a, b, c, d, a1, b1, c1, d1;
output reg [31:0] x, y, z, w;

always @ *//(negedge key_flag)
begin
  case ( count) 
  1:begin 
    x = a;
    y = b;
    z = c;
    w = d;
    end//1
  default: begin
    x = a1;
    y = b1;
    z = c1;
    w = d1;
    end//default
  endcase 
  //end //else 
end //always 
endmodule

