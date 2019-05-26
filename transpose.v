module trans (a,b,c,d,x,y,z,w); 
  input [31:0] a,b,c,d;
  output [31:0] x,y,z,w;
  
  assign x = {a[31:24],b[31:24],c[31:24],d[31:24]};
  assign y = {a[23:16],b[23:16],c[23:16],d[23:16]};
  assign z = {a[15:8],b[15:8],c[15:8],d[15:8]};
  assign w = {a[7:0],b[7:0],c[7:0],d[7:0]};
 
endmodule 