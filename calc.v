module calc(
	input clk,
	input rst,
	input [7:0] d0_i,
	input [7:0] d1_i,
	input [7:0] d2_i,
	input [7:0] d3_i,
	input [7:0] d4_i,
	input [7:0] d5_i,
	input [7:0] d6_i,
	input [7:0] d7_i,
	input [7:0] d8_i,
	input done_i,
	
	output reg [7:0] data_o,
	output done_o
	
);
reg [9:0] g_sum;
reg done_shift;
/*
reg [9:0] gx_p;
reg [9:0] gx_n;
reg [9:0] gx_d;

reg [9:0] gy_p;
reg [9:0] gy_n;
reg [9:0] gy_d;

reg [9:0] g_sum;
reg [3:0] done_shift;

always@(posedge clk) begin
	if(rst) begin
		gx_p <= 0;
		gx_n <= 0;
	end
	else begin
		gx_p <= d6_i + (d3_i << 1) + d0_i;
		gx_n <= d8_i + ( d5_i << 1) + d2_i;
	end
end

always@(posedge clk) begin
	if(rst) begin
		gy_p <= 0;
		gy_n <= 0;
	end
	else begin
		gy_p <= d0_i + (d1_i << 1) + d2_i;
		gy_n <= d6_i + ( d7_i << 1) + d8_i;
	end
end

always@(posedge clk) begin
	if(rst) begin
		gx_d <= 0;
	end
	else begin
		gx_d <= (gx_p >= gx_n) ? (gx_p - gx_n) : (gx_n - gx_p);
	end
end

always@(posedge clk) begin
	if(rst) begin
		gy_d <= 0;
	end
	else begin
		gy_d <= (gy_p >= gy_n) ? (gy_p - gy_n) : (gy_n - gy_p);
	end
end

always@(posedge clk) begin
	if(rst) begin
		g_sum <= 0;
	end
	else begin
		g_sum <= gx_d + gy_d;
	end
end
*/
//ham gausian
always@(posedge clk) begin
	if(rst) begin
	g_sum <=0;
	end
	else begin
		//g_sum <= (d0_i + d1_i *2 + d2_i * 1 + d3_i * 2 + d4_i *4 + d5_i * 2 + d6_i * 1 + d7_i *2 +d8_i * 1)/16;
		g_sum <= d4_i + d5_i -d3_i -d1_i + 2*d8_i - 2*d0_i + d7_i;
	end
end
//

always@(posedge clk) begin
	if(rst) begin
		data_o <= 0;
	end
	else begin
		data_o <=  g_sum[7:0];
	end
end

always@(posedge clk) begin
	if(rst) begin
		done_shift <= 0;
	end
	else begin
		done_shift <= done_i;
	end
end

assign done_o = done_shift;

endmodule