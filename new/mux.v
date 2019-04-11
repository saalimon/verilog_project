`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2018 06:22:40 PM
// Design Name: 
// Module Name: 2BitMUX_32Bit
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


module mux(
    input [1:0] MemtoReg,
    input [31:0] data_from_mem,
    input [31:0] alu_result,
    input [31:0] PC_4,
    output reg [31:0] write_data
    );
    
    always @(*) begin
    
        case( MemtoReg)
            01:begin
                write_data = data_from_mem;
            end
            00:begin
                write_data = alu_result;
            end
            10:begin
                write_data = PC_4;
            end
       
            default: begin 
                write_data = 32'd0;
            end
        endcase
    end  
        
endmodule
