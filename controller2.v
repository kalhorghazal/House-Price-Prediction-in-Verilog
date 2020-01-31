module Controller(input clk, reset, start, EOF, output reg ready ,initDL, next, initEC , enCC, enEC);
  
  reg[2:0] idle=0, first=1, second=2, third=3, fourth=4, fifth=5, sixth=6, seventh=7;
  
  reg [2:0]ps,ns;
  
  always@(ps, start, EOF) 
    begin
    
      case (ps) 
      
        idle: ns = start ? first : idle;
        first: ns = start ? first : second;
        second: ns = fourth;
        third: ns = EOF ? fifth : fourth;
        fourth: ns = third;
        fifth:  ns = seventh;
        sixth: ns = EOF ? idle : seventh;
        seventh: ns = sixth;
        default: ns = idle;
      
        endcase
    end
    
  always@(ps, start, EOF) 
  
   begin
     
     {initDL, next, initEC , enCC, enEC, ready} = 6'b0;
    
      case (ps) 
  
        idle: ready = 1;
        second: initDL =1;
        third: next =  EOF ? 0:1;
        fourth: enCC = EOF ? 0:1;
        fifth: {initDL , initEC} = 2'b11;
        sixth: next =  EOF ? 0:1;
        seventh: enEC = EOF ? 0:1;
        default: {initDL, next, initEC , enCC, enEC, ready} = 6'b0;
        
        endcase
    end
    
    
    always @(posedge clk, posedge reset) 
      begin
		    if(reset) ps <= idle;
		    else ps <= ns;
	     end
 
endmodule
