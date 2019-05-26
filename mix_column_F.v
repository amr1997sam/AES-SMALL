/*
-------------------MIX COLOMNS MODULE---------------------

The INPUT is 4*4 matrix enters in 4 wires a,b,c,d ...EVERY WIRE REPRESENTS A ROW
The OUTPUT is 4*4 matrix enters in 4 wires x,y,z,w ...EVERY WIRE REPRESENTS A ROW
The function mix ...doing the galios_multiplication
*/
module mix_columns (a,b,c,d,x,y,z,w);
  
 
 //INPUTS 
  input [31:0] a ;
  input [31:0] b ;
  input [31:0] c ;
  input [31:0] d ;
 //OUTPUTS
  output [31:0] x;
  output [31:0] y;
  output [31:0] z;
  output [31:0] w;
  //POLY MATRIX
  wire [31:0] p1=32'h02030101 , p2=32'h01020301 , p3=32'h01010203 , p4=32'h03010102 ;
  

    

//FIRST ROW...by multipling the frist row of the poly matrix by the state matrix colomns 
assign x[31:24]= (mix (p1[31:24],a[31:24]) )^ (mix (p1[23:16],b[31:24]) )^ (mix (p1[15:8],c[31:24]) )^ (mix (p1[7:0],d[31:24]) );
assign x[23:16]= (mix (p1[31:24],a[23:16]) )^ (mix (p1[23:16],b[23:16]) )^ (mix (p1[15:8],c[23:16]) )^ (mix (p1[7:0],d[23:16]) );
assign x[15:8]= (mix (p1[31:24],a[15:8]) )^ (mix (p1[23:16],b[15:8]) )^ (mix (p1[15:8],c[15:8]) )^ (mix (p1[7:0],d[15:8]) );
assign x[7:0]= (mix (p1[31:24],a[7:0]) )^ (mix (p1[23:16],b[7:0]) )^ (mix (p1[15:8],c[7:0]) )^ (mix (p1[7:0],d[7:0]) );



//SECOND ROW...by multipling the second row of the poly matrix by the state matrix colomns
assign y[31:24]= (mix (p2[31:24],a[31:24]) )^ (mix (p2[23:16],b[31:24]) )^ (mix (p2[15:8],c[31:24]) )^ (mix (p2[7:0],d[31:24]) );
assign y[23:16]= (mix (p2[31:24],a[23:16]) )^ (mix (p2[23:16],b[23:16]) )^ (mix (p2[15:8],c[23:16]) )^ (mix (p2[7:0],d[23:16]) );
assign y[15:8]= (mix (p2[31:24],a[15:8]) )^ (mix (p2[23:16],b[15:8]) )^ (mix (p2[15:8],c[15:8]) )^ (mix (p2[7:0],d[15:8]) );
assign y[7:0]= (mix (p2[31:24],a[7:0]) )^ (mix (p2[23:16],b[7:0]) )^ (mix (p2[15:8],c[7:0]) )^ (mix (p2[7:0],d[7:0]) );

 

//THIRD ROW...by multipling the third row of the poly matrix by the state matrix colomns
assign z[31:24]= (mix (p3[31:24],a[31:24]) )^ (mix (p3[23:16],b[31:24]) )^ (mix (p3[15:8],c[31:24]) )^ (mix (p3[7:0],d[31:24]) );
assign z[23:16]= (mix (p3[31:24],a[23:16]) )^ (mix (p3[23:16],b[23:16]) )^ (mix (p3[15:8],c[23:16]) )^ (mix (p3[7:0],d[23:16]) );
assign z[15:8]= (mix (p3[31:24],a[15:8]) )^ (mix (p3[23:16],b[15:8]) )^ (mix (p3[15:8],c[15:8]) )^ (mix (p3[7:0],d[15:8]) );
assign z[7:0]= (mix (p3[31:24],a[7:0]) )^ (mix (p3[23:16],b[7:0]) )^ (mix (p3[15:8],c[7:0]) )^ (mix (p3[7:0],d[7:0]) );


//FOURTH ROW...by multipling the fourth row of the poly matrix by the state matrix colomns
assign w[31:24]= (mix (p4[31:24],a[31:24]) )^ (mix (p4[23:16],b[31:24]) )^ (mix (p4[15:8],c[31:24]) )^ (mix (p4[7:0],d[31:24]) );
assign w[23:16]= (mix (p4[31:24],a[23:16]) )^ (mix (p4[23:16],b[23:16]) )^ (mix (p4[15:8],c[23:16]) )^ (mix (p4[7:0],d[23:16]) );
assign w[15:8] = (mix (p4[31:24],a[15:8]) ) ^ (mix (p4[23:16],b[15:8]) ) ^ (mix (p4[15:8],c[15:8]) ) ^ (mix (p4[7:0],d[15:8]) );
assign w[7:0]  = (mix (p4[31:24],a[7:0]) )  ^ (mix (p4[23:16],b[7:0]) )  ^ (mix (p4[15:8],c[7:0]) )  ^ (mix (p4[7:0],d[7:0]) );

 





//POLY_MULTIPLICATION
function [7:0] mix;
  input [7:0] i, k;
  reg [7:0] m1 , m2;
  begin
    
    case(i) //THE POLY MATRIX HAS ONLY 01 , 02 , 03 ...  so we will empliment only multipling by 01 , 02 , 03
      
      8'h01:mix=k;   //while multipling by 1 ...mix(the multipling output) = k(the state byte that will be multiplied by poly one )
      8'h02: begin   //multipling by 2
               if (k[7]==1'b0)  //if the most significant bit = 0 ...multiplication will cause no overflow
                 begin
                   mix=k<<1;   //multipling by 2 causes shift left 1 bit
                 end
               else begin
                     mix= (k<<1)^(8'h1b); //but when the most significant bit =1 ..multiplication will cause overflow so dividing by 283 is a must
                    end
             end
      8'h03: begin  //multipling by 3 
               m1=k;  //multipling by 1
                if (k[7]==1'b0)
                  begin
                   m2=k<<1;
                 end
               else begin
                     m2= (k<<1)^(8'h1b);  //multipling by 2
                    end
                mix =m1^m2; // multipling by 3 = multipling by (1^2)
             end
      default: mix=8'h00;
               
    endcase
  end
endfunction
endmodule