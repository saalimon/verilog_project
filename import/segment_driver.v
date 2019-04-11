`timescale 1ns / 1ps

module SegmentDriver(
    input clk_200Hz,
    input [15:0] value,

    // 7-segment
    output reg [6:0] seg,
    output dp,
    output [3:0] an
    );
    
    reg [4:0] number;
    reg [1:0] digits = 2'b00;
    
    assign an = ~(1 << digits);
    assign dp = 1'b1;
    
    always @ (*) begin
        case (digits)
            2'b00: number = value[3:0];
            2'b01: number = value[7:4];
            2'b10: number = value[11:8];
            2'b11: number = value[15:12];
        endcase
        
        case(number)
            0:seg = 7'b1000000;
            1:seg = 7'b1111001;
            2:seg = 7'b0100100;
            3:seg = 7'b0110000;
            4:seg = 7'b0011001;
            5:seg = 7'b0010010;
            6:seg = 7'b0000010;
            7:seg = 7'b1111000;
            8:seg = 7'b0000000;
            9:seg = 7'b0010000;
            default: seg = 7'b1111110;
        endcase
    end
    
    always @ (posedge clk_200Hz) begin
        digits <= digits + 1;
    end
    
endmodule










