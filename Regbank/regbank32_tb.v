module regbanktb ();

// Inputs to the 32 x 32 Register Bank
// regSelSrc0, regSelSrc1, regSelDst are the selectors of the
// Register location of Src0, Src1, Dst,
// From ALU perspective Src0, Src1 are inputs
// Dst is the ouput of ALU
// Clk is the positive edge clock
// CSBar is the negative level register bank chip select 
// RDWRBar - RD is positive level, WR is negative level
reg [31:0] regDst ;
reg [4:0] regSelSrc0, regSelSrc1, regSelDst;
reg RDWRBar, CSBar, clk, reset;

// Output of the 32 X 32 Register bank
// These feed the ALU
wire [31:0] regSrc0, regSrc1;
integer i;

regBank32 RegB(.regSrc0(regSrc0), .regSrc1(regSrc1), .regDst(regDst),
.regSelSrc0(regSelSrc0), .regSelSrc1(regSelSrc1), .regSelDst(regSelDst), 
.RDWRBar(RDWRBar), .CSBar(CSBar), .clk(clk), .reset(reset) );

always  #5 clk = ~clk;
initial begin
    $dumpfile("regbank.vcd");
    $dumpvars (0, regbanktb );
     clk = 0;
     regSelDst = 5'b 00000;
     regDst = 32'hFAEAFAEA;
     RDWRBar = 1'b1;
     CSBar = 1'b1;
// Apply reset to the register bank
#2 reset  = 1'b0; 
#7 reset  = 1'b1; // release the reset
     
// Write into location Reg[0] with pattern 8h'FAEAFAEA
    #10 regSelDst = 5'b 00011;
        RDWRBar = 1'b0;
        CSBar = 1'b0;
    $display("T=%d, regSelSrc0=%h, regSelSrc1=%h, regSelDst=%h, RDWRBar=%b, CSBar=%b, regSrc0=%h, regSrc1=%h, regDst=%", $time,regSelSrc0, regSelSrc1,regSelDst,RDWRBar, CSBar, regSrc0,regSrc1,regDst);

//Deselect CS 
   #20 RDWRBar = 1'b1;
        CSBar = 1'b1;
        $display("T=%d, regSelSrc0=%h, regSelSrc1=%h, regSelDst=%h, RDWRBar=%b, CSBar=%b, regSrc0=%h, regSrc1=%h, regDst=%", $time,regSelSrc0, regSelSrc1,regSelDst,RDWRBar, CSBar, regSrc0,regSrc1,regDst);

// Read the value from Reg[0] to regSrc0
    #10 regSelSrc0 = 5'b00011;
        RDWRBar =  1'b 1;
        CSBar   =  1'b 0;
        $display("T=%d, regSelSrc0=%h, regSelSrc1=%h, regSelDst=%h, RDWRBar=%b, CSBar=%b, regSrc0=%h, regSrc1=%h, regDst=%", $time,regSelSrc0, regSelSrc1,regSelDst,RDWRBar, CSBar, regSrc0,regSrc1,regDst);
    #15 CSBar = 1'b1 ;

 // Store all location of RegBank with i*10   
#10 CSBar = 0;
#10
 for (i=0; i <= 31; i=i+1)
 begin
     RDWRBar = 0;
     regSelDst = i;
     regDst  = i * 10;
 #12  RDWRBar = 1'b1;
 end
// Read all the locations of RegBank
 #10
for (i=0; i <= 31; i=i+1)
 begin
     RDWRBar = 1'b1;
     regSelSrc0 = i;
     regSelSrc1 = i; 
  #12 RDWRBar = 1'b0;
 end
#1000 $finish;

end


endmodule