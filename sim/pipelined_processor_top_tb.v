`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2026 03:24:00 AM
// Design Name: 
// Module Name: pipelined_processor_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipelined_processor_top_tb();

reg clk = 0, rst;

pipelined_processor_top dut(.clk(clk), .rst(rst));

always begin
    clk = ~clk;
    #50;
end

initial begin
    rst <= 1'b0;
    #200;
    rst <= 1'b1;
    #1000;
    $finish;
end

endmodule
