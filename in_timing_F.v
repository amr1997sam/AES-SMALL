module in_fetch_timing(clk,rst,a,b,c,d,x,y,z,w,load,key_rst, enc);

input clk,rst;
input [31:0] a,b,c,d;
output reg [31:0] x, y, z, w;
output reg load, key_rst;
//output reg outtrig;
output reg [5:0] enc;
reg [4:0] after_rst_ctr;

 
always@(posedge clk)
begin
  if (rst)
  begin
    load <= 0;
    enc <= 0;
    after_rst_ctr <=0;
  end//if_true
  else //rst
  begin
    
    if (after_rst_ctr <18)
      after_rst_ctr <= after_rst_ctr +1;
    if(after_rst_ctr ==17)
      key_rst <= 1;
      
    case (enc)
      0: begin
          load <= 1;
          enc <= enc +1 ;
          end
      16: begin
          load <=0;
          enc <= enc +1 ;
          end
      17: begin
            x <= a;
            y <= b;
            z <= c;
            w <= d;
            enc <= enc +1 ;
          end //case17
      /*18:begin
        outtrig<=1;
        enc <= enc +1 ;
         end*/
      40: begin
            enc <=1 ;
            load <=1;
            //outtrig<=0;
                  
          end//case 23
        
      default: begin
                 enc <= enc +1 ;                 
               end//case default
    endcase
  end//else_rst
end//always

//unset key_rst at negative edge before the next positive edge at which a row to be transmitted, we must prevent resetting for more than 1 cycle
always @(negedge clk)
begin 
  if (after_rst_ctr == 18)
    key_rst <=0 ;
end//always2
endmodule

