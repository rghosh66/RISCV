// Test bench to test 32 bit Carry Look ahead adder
module CLA32tb();

reg [31:0] A, B;
reg CIN = 1'b0 ;
wire [31:0] S;
wire COUT;
integer i;

CLA32 CLA32_UUT(.a(A), .b(B), .s(S), .cout(COUT), .cin(CIN) );

initial begin
    $dumpfile("CLA32.vcd");
    $dumpvars (0, CLA32tb );
    $monitor("Time = %d, A=%h, B=%h, CIN=%b ==> Sum=%h, COUT=%b" , $time, A,B,CIN, S, COUT);
end


initial
begin
  #5 CIN = 1;
  for(i=0;i<=32; i=i+1)
   begin
    #5 A = i; B=i ; CIN = 0;
    #5 A = i; B=i ; CIN = 1;
   // $display( "Time = %d, A=%h, B=%h, CIN=%b ==> Sum=%h, COUT=%b" , $time, A,B,CIN, S, COUT) ;
   end
#10 $finish;

end

endmodule