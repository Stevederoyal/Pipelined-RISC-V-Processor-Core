`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2026 10:41:54 AM
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit(
    rst, RegWriteM, RegWriteW, Rs1D, Rs2D, ResultSrcE, PCSrcE, Rs1E, Rs2E, RdE, RdM, RdW, 
    ForwardAE, ForwardBE, StallF, StallD, FlushD, FlushE 
    );
    
    //Declaration of I/Os
    input rst, RegWriteM, RegWriteW, ResultSrcE, PCSrcE;
    input [4:0] Rs1E, Rs2E, RdM, RdW, Rs1D, Rs2D, RdE;
    
    output StallF, StallD, FlushD, FlushE;
    output reg [1:0] ForwardAE, ForwardBE;
    
    wire lwStall;
    
    //Forwarding to solve data hazards
    //For MuxA
    always@(*) begin
        if(rst == 1'b0) ForwardAE = 2'b00;
        else if (RegWriteM && RdM != 5'b0 && (RdM == Rs1E)) ForwardAE = 2'b10; //Memory stage
        else if (RegWriteW && RdW != 5'b0 && (RdW == Rs1E)) ForwardAE = 2'b01; //Writeback stage
        else ForwardAE = 2'b00;        
    end
    
    //For MuxB
    always@(*) begin
        if(rst == 1'b0) ForwardBE = 2'b00;
        else if (RegWriteM && RdM != 5'b0 && (RdM == Rs2E)) ForwardBE = 2'b10; //Memory stage
        else if (RegWriteW && RdW != 5'b0 && (RdW == Rs2E)) ForwardBE = 2'b01; //Writeback stage
        else ForwardAE = 2'b00;        
    end
    
    //Stall when a load hazard occurs:
    assign lwStall = ResultSrcE & ((Rs1D == RdE) | (Rs2D == RdE));
    assign StallF = lwStall;
    assign StallD = lwStall;

    //Flush when a branch is taken or a load introduces a bubble:
    assign FlushD = PCSrcE;
    assign FlushE = lwStall | PCSrcE;
    
endmodule
