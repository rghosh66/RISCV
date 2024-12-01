// Data flow modelling of full adder
// x,y, cin are the inputs
// s, cout are the outputs
module FA_df (s,cout,x,y,cin);
output s, cout;
input x,y,cin;

assign {cout, s} = x + y + cin;
endmodule
