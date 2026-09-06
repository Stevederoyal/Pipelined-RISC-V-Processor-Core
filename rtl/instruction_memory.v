`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 02:49:24 AM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    input [31:0] A,
    input rst,
    output [31:0] RD
    );
    
    //Creation of Memory
    reg [31:0] Mem [1023:0];
    
    assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];
    
    initial begin
        //Mem[0] = 32'hFFC4A303; //lw x6, -4(x9)
        //Mem[1] = 32'h00832383; //lw x7, 8(x6)
        
        //Mem[0] = 32'h0064A423; //sw x6, 8(x9)
        //Mem[1] = 32'h00B62423; //sw x11, 8(x12)
        
        //Mem[0] = 32'h0062E233;  //or x4, x5, x6
        
        $readmemh("memfile.mem", Mem);

    end
    
endmodule
