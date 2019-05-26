module last (top0,top1,top2,top3,ptext0,ptext1,ptext2,ptext3,cipher_text);
  
  input[31:0] top0 ;
  input[31:0] top1 ;
  input[31:0] top2 ;
  input[31:0] top3 ;
  
  input[31:0] ptext0;
  input[31:0] ptext1;
  input[31:0] ptext2;
  input[31:0] ptext3;
  
  wire[31:0] ctext0;
  wire[31:0] ctext1;
  wire[31:0] ctext2;
  wire[31:0] ctext3;
  
  wire [31:0] t0, t1, t2, t3;
  
  output [127:0] cipher_text;
  
  trans text_trans (top0, top1, top2, top3, t0, t1, t2, t3);
  
  assign ctext0 = t0 ^ ptext0 ;
  assign ctext1 = t1 ^ ptext1 ;
  assign ctext2 = t2 ^ ptext2 ;
  assign ctext3 = t3 ^ ptext3 ;
  
  assign cipher_text={ctext0,ctext1,ctext2,ctext3}; 
  
endmodule
