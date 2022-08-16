module iiitb_SDM(din, reset, clk, y);
input din;
input clk;
input reset;
output reg y;
reg [2:0] cst, nst;
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;
always@(posedge clk, posedge reset)
begin
           if (reset==1)
             cst <= S0;
           else
             cst <= nst;
end          
always @(cst , din)
 begin
 case (cst)
   S0:begin 
        if (din == 1'b1)
           nst <= S1;
        else
          nst <= cst;
      end
   S1: begin
        if (din == 1'b0)
          nst <= S2;
         else
          nst <= cst;
      end          
   S2: begin
        if (din == 1'b1)
           nst <= S3; 
        else          
           nst <= S0; 
      end  
   S3: begin
       if (din == 1'b0)          
         nst <= S2; 
       else          
          nst <= S1;
       end
   default: nst <= S0;
  endcase
end
always @ (posedge clk) begin
    if (reset==1) y <= 1'b0;
    else begin
      if (~din & (cst == S3)) y <= 1'b1;
      else y <= 1'b0;
    end
end
endmodule
