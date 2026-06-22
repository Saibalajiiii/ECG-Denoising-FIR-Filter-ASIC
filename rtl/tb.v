
`timescale 1ns/1ps
`include "filter_64.v"

module tb;

reg ce,rst,clk;
reg [15:0]x;
wire [31:0]y;

filter_64 uut(ce,rst,x,clk,y);
initial begin
clk=0;
 end
always #5 clk=~clk;

initial begin
rst=1'b1;
ce=1'b1;
x=16'b0;
#50
rst=0;
x=16'b0;
#650
$display("x=%d ,y=%d",$signed(x),$signed(y));
x=16'b01;
#650
$display("x=%d ,y=%d",$signed(x),$signed(y));
$finish;
end


initial begin
$fsdbDumpfile("test.fsdb");
$fsdbDumpvars(0,tb);
end
endmodule
