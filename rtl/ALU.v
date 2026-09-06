`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2026 06:25:07 PM
// Design Name: 
// Module Name: ALU
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


module ALU(A,B,ALUControl,Result,Z,N,V,C);

    //declaring inputs
    input [31:0 ]A, B;
    input [2:0] ALUControl;
    
    //declaring outputs
    output [31:0] Result;
    output Z, N, V, C;
    
    //declaring interim wires
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    
    wire [31:0] mux_1;
    wire [31:0] sum;
    wire [31:0] mux2;
    wire [31:0] slt;
    wire cout;
    
    //Logic design
    //AND Operation
    assign a_and_b = A & B;
    
    //OR Operation
    assign a_or_b = A | B;
    
    //NOT Operation on B
    assign not_b = ~B;
    
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;
    
    //Addition / Subtraction Operation
    assign {cout,sum} = A + mux_1 + ALUControl[0];
    
    //Zero Extention
    assign slt = {31'b0,sum[31]};
    
    //Designing 4by1 Mux
    //always @(*) begin
    //    case (ALUControl[2:1])
    //        2'b00 : Result = sum;
    //        2'b01 : Result = sum;
    //        2'b10 : Result = a_and_b;
    //        2'b11 : Result = a_or_b;
    //        default : Result = 32'b0;
    //    endcase
    //end
    
    //Designing 4by1 Mux
    assign mux2 = (ALUControl[2:0] == 3'b000) ? sum : 
                  (ALUControl[2:0] == 3'b001) ? sum : 
                  (ALUControl[2:0] == 3'b010) ? a_and_b :
                  (ALUControl[2:0] == 3'b011) ? a_or_b :
                  (ALUControl[2:0] == 3'b101) ? slt : 32'b0;
                  
   
   assign Result = mux2; 
   
   
   //Flags Assignment
   assign Z = &(~Result); //Zero flag
   assign N = Result[31]; //Negative flag
   assign C = (~ALUControl[1]) & cout; //Carry flag
   assign V = (~(A[31] ^ B[31] ^ ALUControl[0])) & (A[31] & sum[31]) & (~ALUControl[1]); //Overflow flag
   
   
endmodule
