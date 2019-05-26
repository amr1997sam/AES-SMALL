/*
-------------------SHIFT ROWS MODULE---------------------

The INPUT is 4*4 matrix enters in 4 wires a,b,c,d ...EVERY WIRE REPRESENTS A ROW
The OUTPUT is 4*4 matrix enters in 4 wires x,y,z,w ...EVERY WIRE REPRESENTS A ROW
*/
module shift_rows (a,b,c,d,x,y,z,w);
//INPUTS  
input [31:0] a;
input [31:0] b;
input [31:0] c;
input [31:0] d; 
//OUTPUTS
output  [31:0] x;
output  [31:0] y;
output  [31:0] z;
output  [31:0] w; 

assign x = a; //the first row will get no shift 
assign y = {b[23:0] , b[31:24]}; //second row will be shifted by 1 byte(8 bits)
assign z = {c[15:0] , c[31:16]}; //third row will be shifted by 2 bytes(16 bits)
assign w = {d[7:0] , d[31:8]};  //fourth row will be shifted by 3 bytes(24 bits)
endmodule
