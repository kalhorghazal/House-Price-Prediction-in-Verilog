module Controller2(input clk, reset, start, EOF, output reg ready ,initDL, next, initEC , enCC, enEC);
  
  reg[2:0] idle=0, first=1, second=2, third=3, fourth=4, fifth=5;
  
  reg [2:0]ps,ns;
  
  always@(ps, start, EOF) 
    begin
    
      case (ps) 
      
        idle: ns = start ? first : idle;
        first: ns = start ? first : second;
        second: ns = EOF ? idle : fourth;
        third: ns = EOF ? idle : fourth;
        fourth: ns = fifth;
        fifth:  ns = third;
        default: ns = idle;
      
        endcase
    end
    
  always@(ps, start, EOF) 
  
   begin
     
     {initDL, next, initEC , enCC, enEC, ready} = 6'b0;
    
      case (ps) 
  
        idle: ready = 1;
        first: ready = 1;
        second: {initDL , initEC} = 2'b11;
        third: next =  EOF ? 0:1;
        fourth: enCC = EOF ? 0:1;
        fifth: enEC = EOF ? 0:1;
        default: {initDL, next, initEC , enCC, enEC, ready} = 6'b0;
        
        endcase
    end
    
    
    always @(posedge clk, posedge reset) 
      begin
		    if(reset) ps <= idle;
		    else ps <= ns;
	     end
 
endmodule
