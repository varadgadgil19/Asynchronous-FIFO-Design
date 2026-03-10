module synchronizer #(parameter WDT = 3)(
  input clk, rst,
  input [WDT : 0] data_in,
  output reg [WDT : 0] data_out
);
  
  reg [WDT : 0] r1;
  
  always@(posedge clk)begin
    if(!rst)begin
      r1 <= 0;
      data_out <= 0;
    end
    else begin
      r1 <= data_in;
      data_out <= r1;
    end
  end
  
endmodule
