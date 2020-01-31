module Data_path(input clk, reset, initDL, next, initEC, enCC, enEC, output EOF, output [19:0]E);
  
wire [19:0] x, y, B0, B1;
  
Data_loader DataLoader(clk, reset, initDL, next, x, y, EOF);

Coefficient_calculator CoefficientCalculator(clk , reset ,enCC , x , y , B0 , B1);
  
Error_checker ErrorChecker(clk, reset, enEC, initEC, x, y, B0, B1, E);
endmodule
