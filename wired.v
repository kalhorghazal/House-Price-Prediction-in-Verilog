module wired(input clk, reset, start, output ready, output [19:0]E);
  
   wire initDL, next, initEC, enCC, enEC, EOF;
   
   Data_path dp(clk, reset, initDL, next, initEC, enCC, enEC, EOF, E);
   Controller controller(clk, reset, start, EOF, ready ,initDL, next, initEC , enCC, enEC);
 
 endmodule
