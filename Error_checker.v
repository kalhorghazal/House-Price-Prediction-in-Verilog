`timescale 1ns/1ns

module Error_checker(input clk, reset, en, initEC, input [19:0] X, Y,  input [19:0]B0, B1, output [19:0]E);
  
  integer file_e;
  
  wire [19:0] h;
  wire [9:0] msb, lsb;
  
  wire [39:0] mult;
  assign mult = B1*X;
  assign h = B0 + mult[29:10];
  assign E = Y - h;
  assign {msb, lsb} = E;
  
  initial begin
    file_e = $fopen("e_value.txt", "w");
    if (file_e == 1) begin
      $display("file_e handle was NULL");
      $finish;
    end
  end
  
  always @(posedge clk, posedge reset) begin
    if(reset | initEC) begin
      $fclose(file_e);
      file_e = $fopen("e_value.txt", "w");
      if(en)
        $fwrite(file_e, "%b.%b\n", msb, lsb);
    end
    else if(en ) begin
      $fwrite(file_e, "%b.%b\n", msb, lsb);     
    end
  end 
  
endmodule
