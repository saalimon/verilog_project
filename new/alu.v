`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/21/2018 02:32:25 PM
// Design Name:
// Module Name: alu
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


module ALU(
  input [5:0]   shamt,
	input [31:0]	a,
	input [31:0]	b,
	input [3:0] alu_con,
	output reg [31:0]		s,
	output 		zero
	);

	always @(*) begin
    		case(alu_con)
    		/*ADD*/
        			4'b0010:
        				    s = a + b;
        		/*SUB & BEQ*/
        			4'b0110:
        				    s = a - b;
        			/*AND*/
        			4'b0000:
        				    s = a && b;
        		/*OR*/
        			4'b0001:
        				    s = a || b;
        		/*SLT*/
        			4'b0111:
        				    s = a < b;
        		/*SLL*/
        			4'b1111:
        			      s = b << (shamt);
              default:
                    s = 32'd0;
    	   endcase
	end
    assign zero = (s == 0) ? 1:0;

endmodule
