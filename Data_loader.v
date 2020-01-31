`timescale 1ns/1ns

module Data_loader(input clk, rst, init, next, output [19:0] X, Y, output reg EOF);
  
  integer file_x, file_y;
  integer scan_x, scan_y;
  
	reg [9:0] msb_x, lsb_x;
	reg [9:0] msb_y, lsb_y;
	
	reg delim;
	
  assign X = {msb_x, lsb_x};
  assign Y = {msb_y, lsb_y};
  
  initial begin
    file_x = $fopen("x_value.txt", "r");
    EOF = 1'b0;
    if (file_x == 1) begin
      $display("file_x handle was NULL");
      $finish;
    end
  end
  
  initial begin
    file_y = $fopen("y_value.txt", "r");
    EOF = 1'b0;
    if (file_y == 1) begin
      $display("file_y handle was NULL");
      $finish;
    end
  end

	always @(posedge clk, posedge rst) begin
	  
    if(rst | init) begin
      $fclose(file_x);
      file_x = $fopen("x_value.txt", "r");
      scan_x = $fscanf(file_x, "%b%c%b\n", msb_x, delim, lsb_x);
      
      EOF = 1'b0;
    end
    else if(next) begin
      if(!$feof(file_x)) begin
        EOF = 1'b0;
        scan_x = $fscanf(file_x, "%b%c%b\n", msb_x, delim, lsb_x);
        
      end
      else EOF = 1'b1;
    end
  end 
  
  always @(posedge clk, posedge rst) begin
  
    if(rst | init) begin
      $fclose(file_y);
      file_y = $fopen("y_value.txt", "r");
      scan_y = $fscanf(file_y, "%b%c%b\n", msb_y, delim, lsb_y);
      
      EOF = 1'b0;
    end
    else if(next) begin
      if(!$feof(file_y)) begin
        EOF = 1'b0;
        scan_y = $fscanf(file_y, "%b%c%b\n", msb_y, delim, lsb_y);
       
      end
      else EOF = 1'b1;
    end
  end 

endmodule
