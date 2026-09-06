`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:35:46 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(A, WD, clk, rst, WE, RD);

input [31:0] A, WD;
input clk,WE,rst;
output [31:0] RD;

//Creation of data memory
reg [31:0] memory [1023:0];

//Reading data 
assign RD = (rst == 1'b0) ? 32'h00000000 : memory[A];

//Writing data
always @(posedge clk) begin
    if(WE) begin
        memory[A] <= WD;
    end
end

initial begin
    memory[0] = 32'h00000000;
    //memory[28] = 32'h00000020;
    //memory[40] = 32'h00000002;
end
endmodule
