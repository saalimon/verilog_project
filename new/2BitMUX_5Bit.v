`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2018 06:22:40 PM
// Design Name: 
// Module Name: 2BitMUX_5Bit
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


module Bit2MUX_5Bit(
    input [1:0] RegDst,
    input [4:0] rt,
    input [4:0] rd,
    output reg [4:0] Write_Register
    );
    
always @(*) begin

    case( RegDst)
        00:begin
        Write_Register = rt;
        end
        01:begin
        Write_Register = rd;
        end
        10:begin //case jal 
        Write_Register = 5'd31;
        end
    
        default: begin 
        Write_Register = 4'd0;
        end
    endcase
end  
    
endmodule
