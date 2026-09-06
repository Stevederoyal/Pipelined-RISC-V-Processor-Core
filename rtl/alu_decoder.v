`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 05:03:26 PM
// Design Name: 
// Module Name: alu_decoder
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


module alu_decoder(
    input op5,
    input [1:0] ALUOp, 
    input [2:0] funct3,
    input funct7_5, 
    output reg [2:0] ALUControl
    );
    
    always@(*) begin
        
        //lw, sw instruction
        if(ALUOp == 2'b00) begin
            ALUControl = 3'b000; //Add
        end
        
        //BEQ instruction
        else if (ALUOp == 2'b01) begin
            ALUControl = 3'b001; //Subtract
        end
        
        //ALU instructions
        else if (ALUOp == 2'b10) begin 
            //add instruction / addi instruction
            if(funct3 == 3'b000 &&({op5,funct7_5} == 2'b00 || {op5,funct7_5} == 2'b01 || {op5,funct7_5} == 2'b10)) begin
                ALUControl = 3'b000; //Add
            end 
            
            //Sub instruction
            else if(funct3 == 3'b000 && {op5,funct7_5} == 2'b11) begin
                ALUControl = 3'b001; //Subtract
            end
            
            //slt instruction
            else if(funct3 == 3'b010) begin
                ALUControl = 3'b101; //set less than
            end
            
            //or instruction
            else if(funct3 == 3'b110) begin
                ALUControl = 3'b011; //or
            end
            
            //and instruction
            else if(funct3 == 3'b111) begin
                ALUControl = 3'b010; //and
            end 
            
            else ALUControl = 3'b000;
        end
    
        else ALUControl = 3'b000;
    end
endmodule
