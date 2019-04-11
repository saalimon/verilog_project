`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/21/2018 03:09:44 PM
// Design Name:
// Module Name: register
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
/*
register rf(
        .clk(clk),
        .rst(rst),
        .reg_write(RegWrite),
        .read_register_1(instruction[25:21]),
        .read_register_2(instruction[20:16]),
        .write_register(RegDst ? instruction[15:11] : instruction[20:16]),
        .write_data(write_data),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
        );
*/
module register(
    input clk,
    input rst,
    input reg_write,
    input [4:0]read_register_1,
    input [4:0]read_register_2,
    input [4:0]write_register,
    input [31:0]write_data,
    output [31:0]read_data_1,
    output [31:0]read_data_2
    );


    reg [31:0] Regfile [0:31];
    integer i = 0;
    assign read_data_1 = Regfile[read_register_1];
    assign read_data_2 = Regfile[read_register_2];

    always @(posedge clk) // Ou combines the block of reset into the block of posedge clk
    begin
        if (rst)
        begin
            for (i=0; i<32; i=i+1)
            begin
                Regfile[i] = 32'd0;
            end
        end

        else if (reg_write == 1'b1) begin
            Regfile[write_register] <= write_data;
        end
    end

endmodule
