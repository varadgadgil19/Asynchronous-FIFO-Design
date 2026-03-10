module wpointer_handler#(parameter PTR_WDT = 3)(
input wclk, wr_en, rst,
  input [PTR_WDT : 0] s_grptr,
  output reg [PTR_WDT : 0] bwptr, gwptr,
  output reg full
);
  
  wire [PTR_WDT : 0] gwptr_next, bwptr_next;
  wire w_full;
  
  assign bwptr_next = bwptr + (wr_en & !full);
  assign gwptr_next = (bwptr_next >> 1) ^ bwptr_next;
  
  always@(posedge wclk or negedge rst)begin
    if(!rst)begin
      bwptr <= 0;
      gwptr <= 0;
    end else begin
      bwptr <= bwptr_next;
      gwptr <= gwptr_next;
    end
  end
  
  always@(posedge wclk or negedge rst)begin
    if(!rst)
      full <= 0;
    else full <= w_full;
  end
  
  assign w_full = (gwptr_next == {~s_grptr[PTR_WDT : PTR_WDT - 1] , s_grptr[PTR_WDT - 2 : 0]});
  
  
endmodule

//read po
