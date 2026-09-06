`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 03:30:56 PM
// Design Name: 
// Module Name: main_decoder
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


module main_decoder_mod(op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

//Declaring inputs
input [6:0] op;

//Declaring outputs
output reg RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
output reg [1:0] ImmSrc, ALUOp;


always @(*) begin
    case(op)
        //lw instruction
        7'b0000011: begin
            RegWrite = 1'b1;
            ImmSrc = 2'b00;
            ALUSrc = 1'b1;
            MemWrite = 1'b0;
            ResultSrc = 1'b1;
            Branch = 1'b0;
            ALUOp = 2'b00;
        end
        
        //sw instruction
        7'b0100011: begin
            RegWrite = 1'b0;
            ImmSrc = 2'b01;
            ALUSrc = 1'b1;
            MemWrite = 1'b1;
            ResultSrc = 1'b0;
            Branch = 1'b0;    
            ALUOp = 2'b00;
        end
        
        //R-type instruction
        7'b0110011: begin
            RegWrite = 1'b1;
            ImmSrc = 2'b00;
            ALUSrc = 1'b0;
            MemWrite = 1'b0;
            ResultSrc = 1'b0;
            Branch = 1'b0;    
            ALUOp = 2'b10;
        end
        
        // I-type ALU (addi)
        7'b0010011: begin
            RegWrite  = 1'b1;
            ImmSrc    = 2'b00;
            ALUSrc    = 1'b1;
            MemWrite  = 1'b0;
            ResultSrc = 1'b0;
            Branch    = 1'b0;
            ALUOp     = 2'b10;
        end
        
        //beq instruction
        7'b1100011: begin
            RegWrite = 1'b0;
            ImmSrc = 2'b10;
            ALUSrc = 1'b0;
            MemWrite = 1'b0;
            ResultSrc = 1'b0;
            Branch = 1'b1;    
            ALUOp = 2'b01;
        end
        
        default: begin
            RegWrite = 1'b0;
            ImmSrc = 2'b00;
            ALUSrc = 1'b0;
            MemWrite = 1'b0;
            ResultSrc = 1'b0;
            Branch = 1'b0;
            ALUOp = 2'b00;
        end    
    endcase
end

endmodule
