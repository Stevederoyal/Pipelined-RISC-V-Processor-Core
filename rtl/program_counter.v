`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 04:19:19 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input [31:0] PCNext,
    input clk,
    input rst,
    output reg [31:0] PC
    );
    
    
    always@(posedge clk) begin
    
        if (rst == 1'b0) begin
            PC <= 32'h00000000;
        end 
        else begin
            PC <= PCNext;
        end
    
    end
    
endmodule
