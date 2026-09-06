`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 10:29:10 AM
// Design Name: 
// Module Name: control_unit_top
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


module control_unit_top_mod(
     input [6:0] op,
     input [2:0] funct3,
     input funct7_5,
     
     output Branch,
     output ResultSrc,
     output MemWrite,
     output ALUSrc,
     output [1:0] ImmSrc,
     output RegWrite, 
     output [2:0] ALUControl
    );
    
    wire [1:0] ALUOp_Top;
    
    main_decoder_mod Main_Decoder(
        .op(op), 
        .RegWrite(RegWrite), 
        .ImmSrc(ImmSrc), 
        .ALUSrc(ALUSrc), 
        .MemWrite(MemWrite), 
        .ResultSrc(ResultSrc), 
        .Branch(Branch), 
        .ALUOp(ALUOp_Top)
    );
    
    alu_decoder ALU_Decoder(
        .op5(op[5]),
        .ALUOp(ALUOp_Top), 
        .funct3(funct3),
        .funct7_5(funct7_5), 
        .ALUControl(ALUControl)
    );
    
endmodule
