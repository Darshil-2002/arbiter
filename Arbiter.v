module arbiter_b (clk,rst,r1,r2,r3,g1,g2,g3);
input clk,rst;
input r1,r2,r3;
output reg g1,g2,g3;
reg [1:0]state;
parameter a = 2'b00, b = 2'b01, c = 2'b10, d = 2'b11; // a = idle b = device 1 is using.

always @(posedge clk)
begin
	if(rst)
	begin
		{g1,g2,g3} <= 3'b000;
		state <= a;
	end
	else
	begin
		case (state)
			a: begin
				if (r1 == 1'b1)
				       state <= b;
				else if (r2 == 1'b1 && r1 == 1'b0)
					state <= c;
				else if ({r1,r2} == 2'b00 && r3 == 1'b1)
					state <= d;
				else
					state <= a;
			end
			b: state <= r1 ? b : r2 ? c : r3 ? d : a;
			c: state <= r2 ? c : r3 ? d : r1 ? b : a;
			d: state <= r3 ? d : r1 ? b : r2 ? c : a;
			default: state <= a;
		endcase
	end
end

always @(state)
begin
	if(state == b)
		{g1,g2,g3} = 3'b100;
	else if(state == c)
		{g1,g2,g3} = 3'b010;
	else if(state == d)
		{g1,g2,g3} = 3'b001;
	else
		{g1,g2,g3} = 3'b000;
end

endmodule
