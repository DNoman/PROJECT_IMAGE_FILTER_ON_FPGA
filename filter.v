module filter(
	input clk,
	input rst,
	
	input [7:0] red_i,
	input [7:0] green_i,
	input [7:0] blue_i,
	input done_i,
	
	output reg [7:0] red_o,
	output reg [7:0] green_o,
	output reg [7:0] blue_o,
	
	output done_o
);
wire [7:0] red,blue,green;
wire done_o1,done_o2;
kernel SOBEL_KERNEL(
	.clk(clk),
	.rst(rst),
	
	.data_i(red_i),
	.done_i(done_i),
	
	.data_o(red),
	.done_o(done_o)
);
 kernel SOBEL_KERNEL1(
	.clk(clk),
	.rst(rst),
	
	.data_i(blue_i),
	.done_i(done_i),
	
	.data_o(blue),
	.done_o(done_o1)
);
kernel SOBEL_KERNEL2(
	.clk(clk),
	.rst(rst),
	
	.data_i(green_i),
	.done_i(done_i),
	
	.data_o(green),
	.done_o(done_o2)
);
always@(*)begin
		red_o <= red;
		green_o <= green ;
		blue_o <= blue;
end 


endmodule