
module fa(sum,c_out,c_in,x,y);  //full adder
   input x,y,c_in;
   output sum,c_out;
   assign {c_out,sum}=x+y+c_in;
endmodule