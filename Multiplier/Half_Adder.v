
module ha(sum,c_out,x,y);  //half adder
   input x,y;
   output sum,c_out;
   assign {c_out,sum}=x+y;
endmodule // ha
