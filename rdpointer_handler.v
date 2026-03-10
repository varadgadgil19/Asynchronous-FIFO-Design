module rdpointer_handler#(PTR_WDT = 3)(
  input rclk, rst, rd_en,
  input [PTR_WDT : 0] s_gwptr,
  output reg [PTR_WDT : 0] brptr, grptr,
  output reg empty
);
  wire [PTR_WDT : 0] brptr_next;
  wire [PTR_WDT : 0] grptr_next;
  
  wire r_empty;
  
  assign brptr_next = brptr + (rd_en & !empty);
  assign grptr_next = (brptr_next >> 1) ^ brptr_next;
  
  always@(posedge rclk or negedge rst)begin
    if(!rst)begin
      brptr <= 0;
      grptr <= 0;
    end else begin
      brptr <= brptr_next;
      grptr <= grptr_next;
    end
  end
  
  always@(posedge rclk or negedge rst)begin
    if(!rst)
      empty <= 1;
    else 
      empty <= r_empty;
  end
  
  assign r_empty = (grptr_next == s_gwptr);
  
endmodule

