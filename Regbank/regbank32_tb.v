module regbanktb ();

// Inputs to the 32 x 32 Register Bank
// regSelSrc0, regSelSrc1, regSelDst are the selectors of the
// Register location of Src0, Src1, Dst,
// From ALU perspective Src0, Src1 are inputs
// Dst is the ouput of ALU
// Clk is the positive edge clock
// CSBar is the negative level register bank chip select 
// RDWRBar - RD is positive level, WR is negative level
reg [32:0] regDst ;
reg [5:0] regSelSrc0, regSelSrc1, regSelDst;
reg RDWRBar, CSBar, clk;

// Output of the 32 X 32 Register bank
// These feed the ALU
wire [32:0] regSrc0, regSrc1;

regBank32 RegB(.regSrc0(regSrc0), .regSrc1(regSrc1), .regDst(regDst),
.regSelSrc0(regSelSrc0), .regSelSrc1(regSelSrc1), .regSelDst(regSelDst), 
.RDWRBar(RDWRBar), .CSBar(CSBar), .clk(clk) );

initial begin
    $dumpfile("regbank.vcd");
    $dumpvar(0, "regbanktb");
     regSelDst = 5'b 00000;
     regDst = 32'hFAEAFAEA;
     RDWRBar = 1'b1;
     CSBar = 1'b1;
// Write into location Reg[0] with pattern 8h'FAEAFAEA
    #10 regSelDst = 5'b 00000;
        RDWRBar = 1'b0;
        CSBar = 1'b0;
    $display("T=%d, regSelSrc0=%h, regSelSrc1=%h, regSelDst=%h, RDWRBar=%b, CSBar=%b, regSrc0=%h, regSrc1=%h, regDst=%", $time,regSelSrc0, regSelSrc1,regSelDst,RDWRBar, CSBar, regSrc0,regSrc1,regDst);

//Deselect CS 
   #20 RDWRBar = 1'b1;
        CSBar = 1'b1;
        $display();

// Read the value from Reg[0] to regSrc0
    #10 regSelSrc0 = 5'b00000;
        RDWRBar =  1'b 1;
        CSBar   =  1'b 0;
        $display();
#5 $finish;

end


endmodule