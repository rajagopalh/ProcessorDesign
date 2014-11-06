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


module partial_product_generator(x, y, PP);
  

input 	[0:8] 	x;
input 	[0:8] 	y;

output 	[0:8]   PP;

genvar i,j;



  for (i = 0; i < 8 ; i = i+1)
    for ( j = 0 ; j < 8 ; j = j+1)
	
 	decoder PP[i:j] (PP,x [i:j],y[i:j]);
  		
  	  
  endmodule