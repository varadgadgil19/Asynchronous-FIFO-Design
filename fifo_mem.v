module fifo_mem #(parameter DEPTH = 8, WIDTH = 8, PTR_WDT = 3)(
input wclk, rclk, rd_en, wr_en,
  input [WIDTH - 1 : 0] data_in,
  input full, empty,
  input [PTR_WDT : 0] brptr, bwptr,
  output  reg [WIDTH - 1 : 0] data_out
);
  
  reg [WIDTH - 1 : 0] fifo [0 : DEPTH - 1];
  
  always@(posedge wclk)begin
    if(wr_en & !full)
      fifo[bwptr[PTR_WDT - 1 : 0]] <= data_in;
   
  end
  
  assign data_out = fifo[brptr[PTR_WDT - 1 : 0]];
  
endmodule
