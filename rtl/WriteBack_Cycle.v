`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2026 05:54:21 PM
// Design Name: 
// Module Name: WriteBack_Cycle
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


module WriteBack_Cycle(
    RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W,
    ResultW
    );
    
    //Declaring I/O ports
    input RegWriteW, ResultSrcW;
    input [4:0] RdW;
    input [31:0] ALUResultW, ReadDataW, PCPlus4W;
    
    output [31:0] ResultW;
    
    mux2by1 result_mux(.a(ALUResultW),
                       .b(ReadDataW),
                       .sel(ResultSrcW),
                       .out(ResultW)
                       );
                          
                   
endmodule
