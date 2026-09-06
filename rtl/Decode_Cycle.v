`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2026 07:24:51 PM
// Design Name: 
// Module Name: Decode_Cycle
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


module Decode_Cycle(
    clk, rst, InstrD, PCD, PCPlus4D, RegWriteW, RdW, ResultW, 
    RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E);

//Declaring I/O
input clk, rst, RegWriteW;
input [4:0] RdW;
input [31:0] InstrD, PCD, PCPlus4D, ResultW;

output reg RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE;
output reg [2:0] ALUControlE;
output reg [4:0] RdE, Rs1E, Rs2E;
output reg [31:0] ImmExtE, RD1E, RD2E, PCE, PCPlus4E;

//Declaring interim wires
wire RegWriteD, MemWriteD, BranchD, ALUSrcD, ResultSrcD;
wire [1:0] ImmSrcD;
wire [2:0] ALUControlD;
wire [4:0] RdD, Rs1D, Rs2D;
wire [31:0] ImmExtD, RD1_D, RD2_D;


//Instantiating the modules
//Control Unit
control_unit_top_mod control_unit(
    .op(InstrD[6:0]),
    .funct3(InstrD[14:12]),
    .funct7_5(InstrD[30]),
     
    .Branch(BranchD),
    .ResultSrc(ResultSrcD),
    .MemWrite(MemWriteD),
    .ALUSrc(ALUSrcD),
    .ImmSrc(ImmSrcD),
    .RegWrite(RegWriteD), 
    .ALUControl(ALUControlD)
    );

//Register file
register_file register_file(
    .clk(clk),
    .rst(rst),
    .A1(InstrD[19:15]),
    .A2(InstrD[24:20]),
    .A3(RdW),
    .WD3(ResultW),
    .WE3(RegWriteW),
    .RD1(RD1_D),
    .RD2(RD2_D)
    );

//Sign Extension
sign_extend sign_extension(
    .In(InstrD), 
    .Imm_Ext(ImmExtD), 
    .ImmSrc(ImmSrcD)
    );

assign RdD = InstrD[11:7];
assign Rs1D = InstrD[19:15];
assign Rs2D = InstrD[24:20];

always @(posedge clk or negedge rst) begin
    if(rst == 1'b0) begin
        RegWriteE <= 1'b0;
        ResultSrcE <= 1'b0;
        MemWriteE <= 1'b0;
        BranchE <= 1'b0;
        ALUSrcE <= 1'b0;
        
        ALUControlE <= 3'b000;
        
        RdE <= 5'b00000;
        
        ImmExtE <= 32'h00000000;
        RD1E <= 32'h00000000;
        RD2E <= 32'h00000000;
        PCE <= 32'h00000000;
        PCPlus4E <= 32'h00000000;  
        
        Rs1E <= 5'h00;
        Rs2E <= 5'h00;     
    end
    else begin
        RegWriteE <= RegWriteD;
        ResultSrcE <= ResultSrcD;
        MemWriteE <= MemWriteD;
        BranchE <= BranchD;
        ALUSrcE <= ALUSrcD;
        
        ALUControlE <= ALUControlD;
        
        Rs1E <= Rs1D;
        Rs2E <= Rs2D;
        RdE <= RdD;
        
        ImmExtE <= ImmExtD;
        RD1E <= RD1_D;
        RD2E <= RD2_D;
        PCE <= PCD;
        PCPlus4E <= PCPlus4D;  
    end
end

endmodule
