`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2026 11:02:01 PM
// Design Name: 
// Module Name: Fetch_Decode_Top
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


module Fetch_Decode_Top(
    clk, rst, PCSrcE, PCTargetE,
    RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, RdE, ImmExtE, PCPlus4E
);

    input clk, rst;
    input PCSrcE;
    input [31:0] PCTargetE;
    
    output RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE;
    output [2:0] ALUControlE;
    output [4:0] RdE;
    output [31:0] ImmExtE, RD1E, RD2E, PCE, PCPlus4E;
    
    //Interim Wires
    wire [31:0] InstrD, PCD, PCPlus4D;
    
    //Connecting modules
    Fetch_Cycle fetch(.clk(clk),
                      .rst(rst), 
                      .PCSrcE(PCSrcE), 
                      .PCTargetE(PCTargetE), 
                      
                      .InstrD(InstrD), 
                      .PCD(PCD), 
                      .PCPlus4D(PCPlus4D)
                      );
                      
    Decode_Cycle decode(.clk(clk), 
                        .rst(rst), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D), 
                        .RegWriteW(), 
                        .RdW(), 
                        .ResultW(),
                         
                        .RegWriteE(RegWriteE), 
                        .ResultSrcE(ResultSrcE), 
                        .MemWriteE(MemWriteE), 
                        .BranchE(BranchE), 
                        .ALUControlE(ALUControlE), 
                        .ALUSrcE(ALUSrcE), 
                        .RD1E(RD1E), 
                        .RD2E(RD2E), 
                        .PCE(PCE), 
                        .RdE(RdE), 
                        .ImmExtE(ImmExtE), 
                        .PCPlus4E(PCPlus4E)
                        );


endmodule
