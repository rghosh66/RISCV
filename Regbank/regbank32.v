module regBank32 (regSrc0, regSrc1, regDst, regSelSrc0, regSelSrc1, regSelDst, 
                             RDWRBar, CSBar, clk);

output reg[31:0] regSrc0;
output reg[31:0] regSrc1;
input [31:0] regDst ;
input [4:0] regSelSrc0, regSelSrc1, regSelDst ;
input CSBar, RDWRBar, clk ;

// Define the register bank 32 bit x 32 locations
    reg [31:0] regBank[31:0];


// Assign the registers based on register selection inputs
    always @(posedge clk)
    begin
     if (~CSBar)
      case (RDWRBar)
      // Write to the register bank as RWRBar is low
        1'b0: regBank[regSelDst] <=regDst;
      // Read from the register bank as RDWRBar is high
        1'b1: 
        begin
             regSrc0 <= regBank[regSelSrc0] ;
             regSrc1 <= regBank[regSelSrc1] ;
        end
      //  default: 
      endcase
      else begin
              // will have to assign undefined X
              // regSrc0= 32'b0;
               regSrc1= 32'b0;
        end
          
    end
   
endmodule