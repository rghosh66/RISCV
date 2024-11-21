module regBank32 (regSrc0, regSrc1, regDst, regSelSrc0, regSelSrc1, regSelDst, 
                             RDWRBar, CSBar, clk, reset);

output reg[31:0] regSrc0;
output reg[31:0] regSrc1;
input [31:0] regDst ;
input [4:0] regSelSrc0, regSelSrc1, regSelDst ;
input CSBar, RDWRBar, clk , reset ;

integer i;

// Define the register bank 32 bit x 32 locations
    reg [31:0] regBank[0:31];




// Assign the registers based on register selection inputs
    always @(posedge clk)
    begin
    // Negative level triggered reset, will reset
    // all the register bank location to '0'

      if (~reset) 
       for (i=0; i<=31; i=i+1) 
        begin
          regBank[i] <= 0 ;
        end

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
               regSrc0= 32'bx;
               regSrc1= 32'bx;
        end
          
    end
   
endmodule