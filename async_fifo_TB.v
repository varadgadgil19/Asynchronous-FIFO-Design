module async_fifo_TB;

  parameter DATA_WIDTH = 8;

  wire [DATA_WIDTH-1:0] data_out;
  wire full;
  wire empty;
  reg [DATA_WIDTH-1:0] data_in;
  reg wr_en, wclk, wrst;
  reg rd_en, rclk, rrst;

  // Queue to push data_in
  reg [DATA_WIDTH-1:0] wdata_q[$], wdata;

  aync_fifo  as_fifo (wclk, wrst,rclk, rrst,wr_en,rd_en,data_in,data_out,full,empty);

  always #10 wclk = ~wclk;
  always #35 rclk = ~rclk;
  
  initial begin
    wclk = 1'b0; wrst = 1'b0;
    wr_en = 1'b0;
    data_in = 0;
    
    repeat(10) @(posedge wclk);
    wrst = 1'b1;

    repeat(2) begin
      for (int i=0; i<30; i++) begin
        @(posedge wclk & !full);
        wr_en = (i%2 == 0)? 1'b1 : 1'b0;
        if (wr_en) begin
          data_in = $urandom;
          wdata_q.push_back(data_in);
        end
      end
      #50;
    end
  end

  initial begin
    rclk = 1'b0; rrst = 1'b0;
    rd_en = 1'b0;

    repeat(20) @(posedge rclk);
    rrst = 1'b1;

    repeat(2) begin
      for (int i=0; i<30; i++) begin
        @(posedge rclk & !empty);
        rd_en = (i%2 == 0)? 1'b1 : 1'b0;
        if (rd_en) begin
          wdata = wdata_q.pop_front();
          if(data_out !== wdata) $error("Time = %0t: Comparison Failed: expected wr_data = %h, rd_data = %h", $time, wdata, data_out);
          else $display("Time = %0t: Comparison Passed: wr_data = %h and rd_data = %h",$time, wdata, data_out);
        end
      end
      #50;
    end

    $finish;
  end
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
