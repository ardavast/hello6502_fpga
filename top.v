module top (
    input wire rst,
    output wire rst_cpu,
	 
    input wire clk,
    output reg clk_cpu,
	 
    input wire [15:0] A,
    output wire [7:0] D,
    output wire [7:0] LED
);

wire dcm_out;
wire counter_out;

clk_10mhz dcm (
    .CLKIN_IN(clk), 
    .RST_IN(~rst), 
    .CLKFX_OUT(dcm_out)
);

clk_1hz counter (
  .clk(dcm_out),
  .thresh0(counter_out)
);

assign rst_cpu = rst;

always @(posedge counter_out) begin
    if (!rst)
	     clk_cpu <= 0;
	 else
	     clk_cpu <= !clk_cpu;
end

assign D = 8'hEA;
assign LED[7:0] = A[7:0];

endmodule