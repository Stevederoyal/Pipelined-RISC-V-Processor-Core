`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 01:48:35 AM
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(In, Imm_Ext, ImmSrc);

    input [31:0] In;
    input [1:0] ImmSrc;
    output [31:0] Imm_Ext; //32 bits
      
    
    assign Imm_Ext = (ImmSrc == 2'b00) ? {{20{In[31]}},In[31:20]} : //I-instruction
                     (ImmSrc == 2'b01) ? {{20{In[31]}}, In[31:25], In[11:7]} : //S-instruction
                     (ImmSrc == 2'b10) ? {{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0} : //B-instruction
                     {{12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0}; //J-instruction (NOT USED)
    
endmodule
