`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2026 10:36:27 PM
// Design Name: 
// Module Name: pipelined_processor_top
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


module pipelined_processor_top(clk, rst);

    //Declaration of I/0s
    input clk, rst;
    
    //Declaration of interim wires
    wire PCSrcE, RegWriteW, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE, 
         RegWriteM, ResultSrcM, MemWriteM, ResultSrcW; 
    wire [1:0] ForwardAE, ForwardBE;       
    wire [2:0] ALUControlE;    
    wire [4:0] RdW, RdE, RdM, Rs1E, Rs2E;    
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1E, RD2E, PCE, ImmExtE, PCPlus4E,
                ALUResultM, WriteDataM, PCPlus4M, ALUResultW, ReadDataW, PCPlus4W;
    
    //Module instantiation
    //Fectch Stage
   Fetch_Cycle fetch(
                     //Input
                     .clk(clk), 
                     .rst(rst), 
                     .PCSrcE(PCSrcE), 
                     .PCTargetE(PCTargetE), 
                     
                     //Output
                     .InstrD(InstrD), 
                     .PCD(PCD), 
                     .PCPlus4D(PCPlus4D)
                     );


    //Decode Stage
    Decode_Cycle decode(
                        //Input
                        .clk(clk), 
                        .rst(rst), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D), 
                        .RegWriteW(RegWriteW), 
                        .RdW(RdW), 
                        .ResultW(ResultW),
                                                
                        //Output
                        .RegWriteE(RegWriteE), 
                        .ResultSrcE(ResultSrcE), 
                        .MemWriteE(MemWriteE), 
                        .BranchE(BranchE), 
                        .ALUControlE(ALUControlE), 
                        .ALUSrcE(ALUSrcE), 
                        .RD1E(RD1E), 
                        .RD2E(RD2E), 
                        .PCE(PCE),
                        .Rs1E(Rs1E),
                        .Rs2E(Rs2E),
                        .RdE(RdE), 
                        .ImmExtE(ImmExtE), 
                        .PCPlus4E(PCPlus4E)
                         );
         
                         
    //Execute Stage
    Execute_Cycle execute(
                          //Input                     
                          .clk(clk), 
                          .rst(rst), 
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
                          .PCPlus4E(PCPlus4E),
                          .ResultW(ResultW),
                          .ForwardAE(ForwardAE),
                          .ForwardBE(ForwardBE),
                          
                          //Output
                          .PCTargetE(PCTargetE), 
                          .PCSrcE(PCSrcE), 
                          .RegWriteM(RegWriteM), 
                          .ResultSrcM(ResultSrcM), 
                          .MemWriteM(MemWriteM), 
                          .ALUResultM(ALUResultM), 
                          .WriteDataM(WriteDataM), 
                          .RdM(RdM), 
                          .PCPlus4M(PCPlus4M)
                          );
                          
                          
     //Memory Access Stage
     Memory_Cycle memory(
                        //Input
                         .clk(clk), 
                         .rst(rst), 
                         .RegWriteM(RegWriteM), 
                         .ResultSrcM(ResultSrcM), 
                         .MemWriteM(MemWriteM), 
                         .RdM(RdM), 
                         .ALUResultM(ALUResultM), 
                         .WriteDataM(WriteDataM), 
                         .PCPlus4M(PCPlus4M),
                         
                         //Output
                         .RegWriteW(RegWriteW), 
                         .ResultSrcW(ResultSrcW), 
                         .ALUResultW(ALUResultW), 
                         .ReadDataW(ReadDataW), 
                         .RdW(RdW), 
                         .PCPlus4W(PCPlus4W)
                         );  
                         

    //Register Writeback Stage
    WriteBack_Cycle  WriteBack(
                            //Input
                            .RegWriteW(RegWriteW), 
                            .ResultSrcW(ResultSrcW), 
                            .ALUResultW(ALUResultW), 
                            .ReadDataW(ReadDataW), 
                            .RdW(RdW),
                            .PCPlus4W(PCPlus4W),
                            
                            //Output
                            .ResultW(ResultW)
                            );   
                            
    //Hazard Unit                        
    hazard_unit Forwarding_block(
                            //Input
                            .rst(rst), 
                            .RegWriteM(RegWriteM), 
                            .RegWriteW(RegWriteW), 
                            .Rs1D(InstrD[19:15]), 
                            .Rs2D(InstrD[24:20]), 
                            .ResultSrcE(ResultSrcE),
                            .PCSrcE(PCSrcE), 
                            .Rs1E(Rs1E), 
                            .Rs2E(Rs2E), 
                            .RdE(RdE), 
                            .RdM(RdM), 
                            .RdW(RdW), 
                            
                            
                            //Output
                            .ForwardAE(ForwardAE), 
                            .ForwardBE(ForwardBE), 
                            .StallF(), 
                            .StallD(), 
                            .FlushD(), 
                            .FlushE()
                            );                                                                   
endmodule
