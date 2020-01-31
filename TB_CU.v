`timescale 1ns/1ns

module TB_CU();
  
 reg clk=0;
 reg reset =0;
 reg start = 0;
 wire ready;
 wire [19:0]E;
 
wired uut(clk, reset, start, ready, E);

initial repeat (2000) begin clk=~clk; #50; end
  
  initial begin
      
    reset=1;
    
    #100;
 
     reset=0;
    
    start = 1 ;
    #100;
    start = 0;
     #100;
  
  end
endmodule

    

