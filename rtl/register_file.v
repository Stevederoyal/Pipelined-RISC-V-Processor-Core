`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 06:16:40 AM
// Design Name: 
// Module Name: register_file
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


module register_file(A1,A2,A3,WD3,WE3,clk,rst,RD1,RD2);

input [4:0] A1, A2, A3;
input [31:0] WD3;
input WE3, clk, rst;
output [31:0] RD1, RD2;

//Creation of memory
reg [31:0] registers [31:0];

//Read functionality
assign RD1 = (rst == 1'b0) ? 32'h00000000 : registers[A1];
assign RD2 = (rst == 1'b0) ? 32'h00000000 : registers[A2];

//Write functionality
always@(posedge clk) begin
    if (WE3 == 1'b1 & (A3 != 5'h00)) begin
        registers[A3] <= WD3;
    end
end

initial begin
    registers[0] = 32'h00000000;
//    registers[9] = 32'h00000020;
//    registers[5] = 32'h00000005;
//    registers[6] = 32'h00000004;
//    registers[11] = 32'h00000028;
//    registers[12] = 32'h00000030;
end


endmodule
