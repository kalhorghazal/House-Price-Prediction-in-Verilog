`timescale 1ns/1ns
module Coefficient_calculator(input clk , reset , en1, input reg [19:0]x , y ,  output [19:0] tempB0 , tempB1 );
  
  reg [39:0] sumx = 0;
  reg [39:0] sumy  = 0;
  
  reg [39:0] meanx = 0;
  reg [39:0] meany = 0;
  reg [79:0] BB1temp=0, BB2temp=0;
  
  reg [39:0] Sxx = 0; 
  reg [39:0] Sxy = 0 ;
   
   reg [79:0] xy=0, x2=0, mmx=0, mmx2=0, mmy=0, mmy2=0;
  reg  [19:0] n = 0;
 
 always @(posedge clk, posedge reset) 
  begin
   if( en1)
    begin
        Sxx = Sxx + mmx2[59:20];
        Sxy = Sxy +  mmy2[59:20];
        n = n + 1; 
        sumx = sumx + {10'b0, x, 10'b0} ;
        sumy = sumy + {10'b0, y, 10'b0} ;     
        meanx = sumx / n ;
        meany = sumy / n ; 
        x2 = ({10'b0, x, 10'b0})*({10'b0, x, 10'b0});
        xy = ({10'b0, x, 10'b0})*({10'b0, y, 10'b0});
        
        mmx=(meanx*meanx);
  
      mmy=(meanx*meany);
      
  mmx2=mmx[59:20]*({n,20'b0});
     
   mmy2=mmy[59:20]*({n,20'b0});
    
   
        Sxx = Sxx + x2[59:20]- mmx2[59:20];
        Sxy = Sxy + xy[59:20]-  mmy2[59:20];
        
        BB1temp=( { Sxy , 40'b0 } /Sxx);
        
        BB2temp=( BB1temp[59:20] )*meanx;
        
        
        end
 
  end
 
    assign tempB1 = BB1temp[49:30] ;
  
  assign tempB0 = meany[29:10] - BB2temp[49:30] ;
    
 endmodule
