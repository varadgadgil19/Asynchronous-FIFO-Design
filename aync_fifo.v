module aync_fifo #(parameter DEPTH = 8, WIDTH = 8)(
  input wclk, wrst,
  input rclk, rrst,
  input wr_en, rd_en,
  input [WIDTH - 1 : 0] data_in,
  output reg  [WIDTH - 1 : 0] data_out,
  output full, empty
);
  localparam PTR_WIDTH = $clog2(DEPTH);
  
  reg [PTR_WIDTH : 0] s_gwptr, s_grptr;
  reg [PTR_WIDTH : 0] gwptr, grptr;
  reg [PTR_WIDTH : 0] bwptr, brptr;
  
  synchronizer #(PTR_WIDTH) syn1(wclk, wrst, grptr, s_grptr);
  synchronizer #(PTR_WIDTH) syn2(rclk, rrst, gwptr, s_gwptr);
  
  wpointer_handler #(PTR_WIDTH) wp(wclk, wr_en, wrst, s_grptr, bwptr, gwptr, full);
  rdpointer_handler #(PTR_WIDTH) wp1(rclk, rrst, rd_en, s_gwptr, brptr, grptr, empty);
  
  fifo_mem #(DEPTH, WIDTH, PTR_WIDTH) f1(wclk, rclk, rd_en, wr_en, data_in, full, empty, brptr, bwptr, data_out);
  
endmodule
