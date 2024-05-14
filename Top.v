module Top (
    input clk,              
    input rst, 
	 output [31:0] out
	 /*output [7:0] red_t,
	 output [7:0] green_t,
	 output [7:0] blue_t,
	 output doneo,
	 output done_i*/
);


parameter RAM_DEPTH = 20000;   
parameter RAM_WIDTH = 8;    


reg [RAM_WIDTH-1:0] memory [0:RAM_DEPTH-1];

reg output_valid;    
reg [9:0] address;
reg [9:0] address1;
reg [9:0] address2;
reg [1:0] counter;
initial begin
address <= 10'b1111111101;
address1 <= 10'b1111111110;
address2 <= 10'b1111111111;
output_valid <= 0;
counter <= 0;
//i <= 32'd51;
end

reg [7:0] red,blue,green;
reg done;
wire [7:0] red_o;
wire [7:0] green_o;
wire [7:0] blue_o;



filter FILTER(
	.clk(clk),
	.rst(rst),
	
	.red_i(red),
	.green_i(green),
	.blue_i(blue),
	.done_i(done),
	
	
	.red_o(red_o),
	.green_o(green_o),
	.blue_o(blue_o),
	
	.done_o(doneo)
);



always @(posedge clk ) begin
    if (rst) begin
			address <= 8'b11111101;
			address1 <= 8'b11111110;
			address2 <= 8'b11111111;
         output_valid <= 0;
    end
    else begin
        /*state <= next_state;
        case(state)
            IDLE: begin
                next_state <= READ_FILE;
            end
            READ_FILE: begin
                $readmemh("text.txt", memory);
                next_state <= IDLE;
                output_valid <= 1;
            end
            default: begin
                output_valid <= 0;
            end
        endcase*/
	     $readmemh("lena1.txt", memory);
		  address <= address +3;
		  address1 <= address1 +3;
		  address2 <= address2 +3;
		  output_valid <= 1;
		  counter <=(counter == 2) ? counter : counter +1;
    end
end

always @(posedge clk) begin
    if (output_valid) begin
        red <= memory[address];
		  green <= memory[address1];
		  blue <= memory[address2];
		  if(counter == 2) begin
				done <= 1;
		  end
		  //i <= i +3;
    end
end
assign out = {blue_o,green_o,red_o};
/*assign red_t = red;
assign blue_t = blue;
assign green_t = green;
assign done_i = done;
assign count = i;*/

endmodule