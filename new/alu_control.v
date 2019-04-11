`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/29/2018 06:08:58 PM
// Design Name:
// Module Name: alu_control
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


module alu_control(
           input [1:0] alu_op,  // ALU 8-bit Inputs
           input [5:0] func,// func fild,
           output reg [3:0] alu_ctrl // ALU 4-bit Output
    );
    //reg [7:0] alu_out;
    //assign alu_ctrl = alu_out;
    always @(*)
    begin
                case(alu_op)
                2'b00: // load word / store word
                begin
                    alu_ctrl = 4'b0010;
                end
                2'b01: // branch equal
                begin
                    alu_ctrl = 4'b0110;
                end
                2'b10:
                begin
                    case(func)
                    6'b100000: // add
                    begin
                        alu_ctrl = 4'b0010;
                    end
                    6'b100010: // subtract
                    begin
                        alu_ctrl = 4'b0110;
                    end
                    6'b100100: // and
                    begin
                        alu_ctrl = 4'b0000;
                    end
                    6'b100101: // or
                    begin
                        alu_ctrl = 4'b0001;
                    end
                    6'b101010: // slt
                    begin
                        alu_ctrl = 4'b0111;
                    end
                    6'b001000: //jr
                    begin
                        alu_ctrl = 4'b0101;
                    end
                    6'b000000: //sll | shift left logical
                    begin
                        alu_ctrl = 4'b1111;
                    end
                    endcase
                end
                endcase
            end
        endmodule
