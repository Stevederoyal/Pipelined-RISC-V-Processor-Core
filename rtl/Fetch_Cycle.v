`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 11:09:40 AM
// Design Name: 
// Module Name: Fetch_Cycle
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


module Fetch_Cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);


//Declaring inputs & outputs
input clk, rst;
input PCSrcE;
input [31:0] PCTargetE;

output reg [31:0] InstrD, PCD, PCPlus4D;

//Declaring interim wires
wire [31:0] PC_F, PCF, PCPlus4F, InstrF;

//Declaration of interim registers 
reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg; 

//Instantiation of Modules
//Declare PC Mux
mux2by1 PC_MUX(.a(PCPlus4F), 
               .b(PCTargetE), 
               .sel(PCSrcE), 
               .out(PC_F));
               

//Declare PC Counter
program_counter Program_Counter(.PCNext(PC_F),
                                .clk(clk),
                                .rst(rst),
                                .PC(PCF));
                                
//Declare Instruction Memory
instruction_memory Instruction_Memory(.A(PCF),
                                      .rst(rst),
                                      .RD(InstrF));
                                      
//Declare PC Adder
PC_Adder PC_adder(.PC(PCF),
                  .b(32'h00000004), 
                  .PCPlus4(PCPlus4F));
                  
//Fetch Cycle Pipeline Register Logic                 
always @(posedge clk or negedge rst) begin
    if(rst == 1'b0) begin
        InstrD <= 32'h0;
        PCD <= 32'h0;
        PCPlus4D <= 32'h0;
    end

    else begin
        InstrD <= InstrF;
        PCD <= PCF;
        PCPlus4D <= PCPlus4F;
    end
end                 

endmodule
