`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2018 06:26:04 PM
// Design Name: 
// Module Name: sign_extended
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


module sign_extended(
    input [15:0] in,
    output reg [31:0] out
    );
    always @(in)
    begin
        out[31:0] <= { {16{in[15]}}, in[15:0] };
    end
endmodule
