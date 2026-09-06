`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2026 09:18:01 AM
// Design Name: 
// Module Name: Memory_Cycle
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


module Memory_Cycle(
    clk, rst, RegWriteM, ResultSrcM, MemWriteM, RdM, ALUResultM, WriteDataM, PCPlus4M,
    RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W
);

    //Declaration of I/Os
    input clk, rst, RegWriteM, ResultSrcM, MemWriteM;
    input [4:0] RdM;
    input [31:0] ALUResultM, WriteDataM, PCPlus4M;
    
    output reg RegWriteW, ResultSrcW;
    output reg [4:0] RdW;
    output reg [31:0] ALUResultW, ReadDataW, PCPlus4W;
    
    //Declaration of interim wires
    wire [31:0] ReadDataM;
    
    //Declaration of module instantiation
    data_memory dmem(.A(ALUResultM), 
                     .WD(WriteDataM), 
                     .clk(clk), 
                     .rst(rst), 
                     .WE(MemWriteM), 
                     .RD(ReadDataM)
                     );
                                          
     always@(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWriteW <= 1'b0;
            ResultSrcW <= 1'b0;
            RdW <= 5'b00000;
            ALUResultW <= 32'h00000000;
            ReadDataW <= 32'h00000000;
            PCPlus4W <= 32'h00000000;
        end
        
        else begin
            RegWriteW <= RegWriteM;
            ResultSrcW <= ResultSrcM;
            RdW <= RdM;
            ALUResultW <= ALUResultM;
            ReadDataW <= ReadDataM;
            PCPlus4W <= PCPlus4M;
        end
     end                

endmodule
