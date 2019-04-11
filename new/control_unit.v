`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/29/2018 03:50:27 PM
// Design Name:
// Module Name: control_unit
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


module control_unit (
            input [5:0] opcode,
            output [1:0]RegDst,
            output MemRead,
            output [1:0]MemtoReg,
            output [1:0] ALUOp,
            output MemWrite,
            output ALUsrc,
            output RegWrite,
            output Branch,
            output Jump,
            output jal,
            output JumpReg
    );
   reg RegDst;
   reg MemRead;
   reg MemtoReg;
   reg [1:0] ALUOp;
   reg MemWrite;
   reg ALUsrc;
   reg RegWrite;
   reg Branch;
   reg Jump;
   reg jal;
   reg JumpReg;
   always @(opcode)
   begin
        case(opcode)

        6'b000011: begin //Jump and link JAL
                RegDst    = 2'b10;
                MemRead   = 0;
                MemtoReg  = 2'b10;
                ALUOp     = 2'b10;
                MemWrite  = 0;
                ALUsrc    = 1'bx;
                RegWrite  = 1; //*** write address to $ra
                Branch    = 0;
                Jump      = 1;
                jal       = 1;
                JumpReg   = 0;
                end
       6'b000010: begin  //jump
                RegDst    = 2'b00;
                MemRead   = 0;
                MemtoReg  = 2'b00;
                ALUOp     = 2'b10;
                MemWrite  = 0;
                ALUsrc    = 1'bx;
                RegWrite  = 0;
                Branch    = 0;
                Jump      = 1;
                jal       = 0;
                JumpReg   = 0;
                end
        6'b000000: begin //R-format
                RegDst    = 2'b01;
                MemRead   = 0;
                MemtoReg  = 2'b00;
                ALUOp     = 2'b10;
                MemWrite  = 0;
                ALUsrc    = 0;
                RegWrite  = 1;
                Branch    = 0;
                Jump      = 0;
                jal       = 0;
                JumpReg   = 0;
                end
          6'b100000: begin //lb
                RegDst    = 2'b00;
                MemRead   = 1;
                MemtoReg  = 2'b01;
                ALUOp     = 2'b00;
                MemWrite  = 0;
                ALUsrc    = 1;
                RegWrite  = 1;
                Branch    = 0;
                Jump      = 0;
                jal       = 0;
                JumpReg   = 0;
                end
        6'b100011: begin //lw
                RegDst    = 2'b00;
                MemRead   = 1;
                MemtoReg  = 2'b01;
                ALUOp     = 2'b00;
                MemWrite  = 0;
                ALUsrc    = 1;
                RegWrite  = 1;
                Branch    = 0;
                Jump      = 0;
                jal       = 0;
                JumpReg   = 0;
                end
        6'b101011: begin //sw
                RegDst    = 2'b00;
                MemRead   = 0;
                MemtoReg  = 2'b00;
                ALUOp     = 2'b00;
                MemWrite  = 1;
                ALUsrc    = 1;
                RegWrite  = 0;
                Branch    = 0;
                Jump      = 0;
                jal       = 0;
                JumpReg   = 0;
                end
        6'b001000: begin //addi
                RegDst    = 2'b00;
                MemRead   = 0;
                MemtoReg  = 2'b00;
                ALUOp     = 2'b00;
                MemWrite  = 0;
                ALUsrc    = 1;
                RegWrite  = 1;
                Branch    = 0;
                Jump      = 0;
                jal       = 0;
                JumpReg   = 0;
                end
        6'b000100: begin //beq
                RegDst    = 2'b00;
                MemRead   = 0;
                MemtoReg  = 2'b00;
                ALUOp     = 2'b01;
                MemWrite  = 0;
                ALUsrc    = 0;
                RegWrite  = 0;
                Branch    = 1;
                Jump      = 0;
                jal       = 0;
                JumpReg   = 0;
                end

        endcase
   end
endmodule
