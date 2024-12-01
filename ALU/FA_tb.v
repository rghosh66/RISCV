// Test bench to test a full adder
module FA_tb ();
// inputs to the 1-bit full adder
reg a0, b0, cin;
// output of the 1-bit full adder
wire s0, cout;
// counter to generate input vectors of 1-bit adder
reg [3:0] seed;

FA_df FA (.s(s0), .cout(cout),.x(a0),.y(b0),.cin(cin));
initial begin
    $dumpfile("FA_tb.vcd");
    $dumpvars(0,FA_tb);
    $monitor("Time: %0t | a0=%b, b0=%b, cin=%b -> s0=%b, cout=%b", 
             $time, a0, b0, cin, s0, cout);
    #5 a0 = 1'b0;
       b0 = 1'b0;
       cin = 1'b0;
       seed = 3'b000;
    while (seed <= 3'b111) begin
        #5 {b0,a0, cin} = seed ;
        seed = seed + 3'b001;
    end
    #50 $finish ;

end
endmodule
