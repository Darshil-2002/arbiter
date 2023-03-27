`include "q10b.v"

module test;

reg clk,rst,r1,r2,r3;
wire g1,g2,g3;

arbiter_b uut(clk,rst,r1,r2,r3,g1,g2,g3);

initial begin
	$monitor("rst = %b r1 = %b r2 = %b r3 = %b g1 = %b g2 = %b g3 = %b",rst,r1,r2,r3,g1,g2,g3);
	$dumpfile("q10b.vcd");
	$dumpvars();
end

always #3 clk = ~clk;

initial begin
	clk = 1'b0; rst = 1'b1; {r1,r2,r3} = 3'b000;
	#4 rst = 1'b0;
	repeat(3) begin
	{r1,r2,r3} = 3'b100; #10;{r1,r2,r3} = 3'b000; #10;
	{r1,r2,r3} = 3'b010; #10;{r1,r2,r3} = 3'b000; #10;
	{r1,r2,r3} = 3'b001; #10;{r1,r2,r3} = 3'b000; #10;
	{r1,r2,r3} = 3'b111; #10;//{r1,r2,r3} = 3'b000; #10;
	{r1,r2,r3} = 3'b011; #10;//{r1,r2,r3} = 3'b000; #10;
	{r1,r2,r3} = 3'b001; #10;//{r1,r2,r3} = 3'b000; #10;
end
#10 $finish;
end
endmodule
