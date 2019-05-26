module int (reset,nonce,data1,data2,data3,data4,on);

input[31:0] data1;
input[31:0] data2;
input[31:0] data3;
input[31:0] data4;

input [5:0] on;

parameter  [63:0] iv=64'hba23890ace346bf1;


output reg [127:0] nonce;




reg [63:0] counter;


reg[31:0] key1;
reg[31:0] key2;
reg[31:0] key3;
reg[31:0] key4;



input reset;



always@(on or counter)
begin
  if (reset==1)
    counter<=0;
else
  begin
    if(on==5'h18)
      begin
         if(counter==0)
           begin
             key1<=data1;
             key2<=data2;
             key3<=data3;
             key4<=data4;
              end
      else 
        begin
          key1<=key1;
          key2<=key2;
          key3<=key3;
          key4<=key4;
          
          end
          end
end
end
  
 
always@(on)
begin
  if(reset==1)
   counter<=0;
  else
    begin
      if(on==5'h18)
        begin
      if((key1==data1)&&(key2==data2)&&(key3==data3)&&(key4==data4))
                 
                 counter<=counter+1;
                 
     else 
       
       counter<=0;
  end
    end//else1
end//always

always@(on or counter )
begin
  if(reset==1)
    nonce<=0;
  else
    if(on==5'h18)
    nonce<={iv,counter};
  else
    nonce<=nonce;
    
end

endmodule
