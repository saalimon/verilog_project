
module program_counter(
    input clk,
    input rst,
    
    input [31:0] new_address,
    output reg [31:0] current_address
    );
    
    always @ (posedge clk) begin
        if (rst) begin
            current_address <= 32'd256;
        end else begin
            current_address <= new_address;
        end
    end
    
endmodule
