`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 10:17:53 PM
// Design Name: 
// Module Name: mux2by1
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


module mux2by1(a,b,sel,out);
    input[31:0] a,b;
    input sel;
    output[31:0] out;
    
   assign out = (sel == 1'b0) ? a : b;
   
endmodule
