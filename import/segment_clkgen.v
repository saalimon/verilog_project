`timescale 1ns / 1ps

module SegmentClockGenerator(
    input clk,
    output reg clk_out = 1'b0
    );
    
    reg [15:0] counter = 16'd0;
    
    always @ (posedge clk) begin
        counter <= counter + 1;
        if (counter == 16'd0) begin
            clk_out <= ~clk_out;
        end
    end
    
endmodule
