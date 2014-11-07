module decoder (x_j, x_j_1, y_i, y_i_1, y_i_p_1, PP_j);  


input 	x_j;
input 	x_j_1;
input 	y_i;
input   y_i_1;
input 	y_i_p_1;

output  PP_j;


wire  Neg, x1_b, z, x2_b;

assign   Neg = y_i_p_1;
assign   x1_b = y_i_1 ^~ y_i;
assign   z = y_i_p_1 ^~ y_i;
assign   x2_b = y_i_1 ^ y_i;

assign PP_j = ~((x1_b ^ (x_j ~^ Neg)) & (( z | (x_j_1 ~^ Neg) | x2_b)));


endmodule // booth_decoder

module sign_converter(x, y, s_u, x_s, y_s)

	input [0:7] x;
	input [0:8] y;
	input s_u;

	output [0:8] x_s;
	output [0:8] y_s;

	for(i = 7 ; i < 15 ; i++)
	{
		assign x_s[i+1] = s_u & x[i];
		assign y_s[i+1] = s_u & y[i];
	}

endmodule
	
module negate( y_i, y_i_1, y_i_p_1, N_i )

	input y_i, y_i_1, y_i_p_1;

	output N_i;

	assign N_i = y_i_p_1 & ~( y_i & y_i_1)


endmodule







module partial_product_generator(x, y, s_u, PP);
  
input [0:7] ori_x;
input [0:7] ori_y;


wire 	[0:15] 	x;
wire 	[0:15]   y;
wire temp;

output	[0:12]	PP_0;
output	[0:12]	PP_1;
output	[0:12]	PP_2;
output	[0:13]	PP_3;




always @ (posedge clk)
{
	
	// Generate row 0

	sign_converter sc1 (ori_x, ori_y, s_u, x, y);

	decode de_00 ( x[0], 0, y[0], 0, y[1], PP_0[0]);
	decode de_01 ( x[1], x[0], y[1], y[0], y[2], PP_0[1]);
	decode de_02 ( x[2], x[1], y[2], y[1], y[3], PP_0[2]);
	decode de_03 ( x[3], x[2], y[3], y[2], y[4], PP_0[3]);
	decode de_04 ( x[4], x[3], y[4], y[3], y[5], PP_0[4]);
	decode de_05 ( x[5], x[4], y[5], y[4], y[6], PP_0[5]);
	decode de_06 ( x[6], x[5], y[6], y[5], y[7], PP_0[6]);
	decode de_07 ( x[7], x[6], y[7], y[6], y[8], PP_0[7]);

	assign PP_0[8] = s_u & PP_0[7];
	assign PP_0[9] = s_u & PP_0[8];
	assign PP_0[10] = ~PP_0[9];

	// Generate row 1


	negate n_1 (y[0], 0, y[1], PP_1[0]);
	assign PP_1[1] = 0;
	decode de_10 ( x[0], 	0, y[1], y[0], y[2], PP_1[2]);
	decode de_11 ( x[1], x[0], y[2], y[0], y[3], PP_1[3]);
	decode de_12 ( x[2], x[1], y[3], y[1], y[4], PP_1[4]);
	decode de_13 ( x[3], x[2], y[4], y[2], y[5], PP_1[5]);
	decode de_14 ( x[4], x[3], y[5], y[3], y[6], PP_1[6]);
	decode de_15 ( x[5], x[4], y[6], y[4], y[7], PP_1[7]);
	decode de_16 ( x[6], x[5], y[7], y[5], y[8], PP_1[8]);
	decode de_17 ( x[7], x[6], y[8], y[6], y[9], PP_1[9]);
	decode de_18 ( x[8], x[7], y[9], y[7], y[10], temp);
	assign PP_1[10] = ~temp;
	PP_1[11] = 1;

	// Generate row 2

	PP_2[0] = 0;
	PP_2[1] = 0;
	negate n_2 (y[0], 0, y[1], PP_2[2]);
	assign PP_2[3] = 0;
	decode de_20 ( x[0], 	0, y[2],  y[1], y[3], PP_2[4]);
	decode de_21 ( x[1], x[0], y[3],  y[2], y[4], PP_2[5]);
	decode de_22 ( x[2], x[1], y[4],  y[3], y[5], PP_2[6]);
	decode de_23 ( x[3], x[2], y[5],  y[4], y[6], PP_2[7]);
	decode de_24 ( x[4], x[3], y[6],  y[5], y[7], PP_2[8]);
	decode de_25 ( x[5], x[4], y[7],  y[6], y[8], PP_2[9]);
	decode de_26 ( x[6], x[5], y[8],  y[7], y[9], PP_2[10]);
	decode de_27 ( x[7], x[6], y[9],  y[8], y[10], PP_2[11]);
	decode de_28 ( x[8], x[7], y[10], y[9], y[11], temp);
	assign PP_2[11] = ~temp;
	PP_2[12] = 1;


	// Generate row 3	

	PP_3[0] = 0;
	PP_3[1] = 0;
	PP_3[2] = 0;
	negate n_3 (y[0], 0, y[1], PP_3[3]);
	assign PP_3[4] = 0;
	decode de_30 ( x[0], 	0, y[3],  y[4],  y[5], PP_3[5]);
	decode de_31 ( x[1], x[0], y[4],  y[5],  y[6], PP_3[6]);
	decode de_32 ( x[2], x[1], y[5],  y[6],  y[7], PP_3[7]);
	decode de_33 ( x[3], x[2], y[6],  y[7],  y[8], PP_3[8]);
	decode de_34 ( x[4], x[3], y[7],  y[8],  y[9], PP_3[9]);
	decode de_35 ( x[5], x[4], y[8],  y[9],  y[10], PP_3[10]);
	decode de_36 ( x[6], x[5], y[9],  y[10], y[11], PP_3[11]);
	decode de_37 ( x[7], x[6], y[10], y[11], y[12], PP_3[12]);
	decode de_38 ( x[8], x[7], y[11], y[12], y[13], temp);
	assign PP_3[12] = ~temp;
	PP_3[13] = 1;



}
 	
  		
  	  
  endmodule