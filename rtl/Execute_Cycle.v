`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2026 12:13:34 AM
// Design Name: 
// Module Name: Execute_Cycle
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


module Execute_Cycle(
    clk, rst, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, RdE, ImmExtE, PCPlus4E, ResultW, ForwardAE, ForwardBE,
    PCTargetE, PCSrcE, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M
);

    //Declaration of I/Os
    input clk, rst, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE;
    input [2:0] ALUControlE;
    input [4:0] RdE;
    input [31:0] ImmExtE, RD1E, RD2E, PCE, PCPlus4E;
    input [31:0] ResultW;
    input [1:0] ForwardAE, ForwardBE;
    
    output PCSrcE;
    output reg RegWriteM, ResultSrcM, MemWriteM;
    output reg [4:0] RdM;
    output[31:0] PCTargetE;
    output reg [31:0] ALUResultM, WriteDataM, PCPlus4M;
    
    
    //Declaration of interim wires 
    wire [31:0] SrcAE, SrcB_interim, SrcBE, ResultE, WriteDataE;
    wire ZeroE;
    
    //Declaration of modules
    //Fowarding Multiplexer for SrcA
    mux4by1 srcAE_mux(
        .a(RD1E),
        .b(ResultW),
        .c(ALUResultM),
        .d(),
        .sel(ForwardAE),
        
        .out(SrcAE)
        );
    
    //Fowarding Multiplexer for SrcB
    mux4by1 srcBE_mux(
        .a(RD2E),
        .b(ResultW),
        .c(ALUResultM),
        .d(),
        .sel(ForwardBE),
        
        .out(SrcB_interim)
        );
    
    
    //ALUSrc Mux
    mux2by1 alu_src_mux(
        .a(SrcB_interim),
        .b(ImmExtE),
        .sel(ALUSrcE),
        .out(SrcBE)
        );
    
    //ALU Unit
    ALU alu(
        .A(SrcAE),
        .B(SrcBE),
        .ALUControl(ALUControlE),
        .Result(ResultE),
        .Z(ZeroE),
        .N(),
        .V(),
        .C()
        );
        
    //Branch Adder
    PC_Adder branch_adder(
        .PC(PCE),
        .b(ImmExtE), 
        .PCPlus4(PCTargetE) 
    );
    
    assign PCSrcE = (ZeroE & BranchE);
    assign WriteDataE = SrcB_interim;
    
    //Pipeline Registers
    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWriteM <= 1'b0;
            ResultSrcM <= 1'b0;
            MemWriteM <= 1'b0;
            
            RdM <= 5'b00000;
            
            ALUResultM <= 32'h00000000;
            WriteDataM <= 32'h00000000;
            PCPlus4M <= 32'h00000000;
        end
        else begin
            RegWriteM <= RegWriteE;
            ResultSrcM <= ResultSrcE;
            MemWriteM <= MemWriteE;
            
            RdM <= RdE;
            
            ALUResultM <= ResultE;
            WriteDataM <= WriteDataE;
            PCPlus4M <= PCPlus4E;
        end
    end
endmodule
