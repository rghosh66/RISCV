// 32 bit Carry Look Ahead Adder
module CLA32(a,b,cin, s, cout);
// a[31:0], b[31:0] are inputs, cin is carryin

input [31:0] a,b;
input cin;

// s[31:0] is the output, cout is carry out
output [31:0] s;
output cout;
// Create the Generate and Propagate nextwork

wire [31:0] g, p, c;
genvar i;
generate
for (i=0; i<= 31; i= i+1)
begin
    assign g[i] = a[i] & b[i], p[i] = a[i] ^ b[i];
 
end
endgenerate

// Create the Carry 

generate
    assign c[0] = cin;
    for (i=0; i<=30; i=i+1)
    begin
    // carry
     assign c[i+1] = g[i] | (c[i] & p[i]);
     //sum
     assign s[i] = c[i] ^ p[i];
    end
    // final carry and sum for the 32 bit
    assign cout = g[31] | (c[31] & p[31]);
    assign s[31] = c[31]^ p[31] ;
    
endgenerate

endmodule