module wallace(r0,r1,r2,r3,result);
   input[7:0] r0,r1,r2,r3;
   output [7:0] result;
   wire [7:0] 	result;
   
   wire 	w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19;
   wire 	o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11;
   wire 	tmp;
   //level 1
   ha ha1(o1,w1,r1[2],r2[2]);
   fa fa2(o2,w2,r2[3],r3[3],r1[3]);
   fa fa3(o3,w3,r1[4],r2[4],r3[4]);
   fa fa4(o4,w4,r1[5],r2[5],r3[5]);
   fa fa5(o5,w5,r1[6],r2[6],r3[6]);
   fa fa17(o10,w16,r0[7],r1[7],r2[7]);
   
   //level 2
   ha ha6(o6,w6,o2,r0[3]);
   fa fa7(o7,w7,w2,o3,r0[4]);
   fa fa8(o8,w8,w3,o4,r0[5]);
   fa fa9(o9,w9,w4,o5,r0[6]);
   fa fa18(o11,w17,w5,o10,r3[7]);
   
   //fast CL A
   not not1(w19,r0[0]);
   not not2(result[0],w19);
   
   ha ha10(result[1],w10,r0[1],r1[1]);
   fa fa11(result[2],w11,w10,r0[2],o1);
   fa fa12(result[3],w12,w11,w1,o6);
   fa fa13(result[4],w13,w12,w6,o7);
   fa fa14(result[5],w14,w13,w7,o8);
   fa fa15(result[6],w15,w14,w8,o9);
   fa fa16(result[7],w18,w15,w9,o11);
endmodule

