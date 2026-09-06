`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2026 05:59:46 PM
// Design Name: 
// Module Name: mux3by1
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


module mux4by1(a,b,c,d,sel,out);
    input[31:0] a,b,c,d;
    input [1:0] sel;
    output reg [31:0] out;
    
   always@(*) begin
    case(sel) 
        2'b00 : out = a;        
        2'b01 : out = b;
        2'b10 : out = c; 
        2'b11 : out = d;
        default: out = {32{1'b0}};
    endcase
   end
   
endmodule
