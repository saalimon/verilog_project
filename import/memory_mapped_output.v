
module memory_mapped_output(
    input clk,
    input rst,
    
    // 7-segment
    output [6:0] seg,
    output dp,
    output [3:0] an,
    
    // switches
    input [3:0] sw,
    
    input [31:0] address,
    input [31:0] write_data,
    input mem_write
    );
    
    // instantiate 7-segment driver module
    wire segment_clk_out;
    wire [15:0] value;
    SegmentClockGenerator segment_clkgen(clk, segment_clk_out);
    SegmentDriver segment_driver(segment_clk_out, value, seg, dp, an);
    
    // instantiate internal memory and memory update logic
    integer i = 0;
    reg [15:0] memory [0:15];
    always @ (posedge clk) begin
        if (rst) begin
            for (i=0; i<15; i=i+1) begin
                memory[i] <= 32'd0;
            end
        end else if (mem_write && !(|address[31:13]) && address[12] && !(|address[11:6])) begin // address should be between 4096-4159 (1000000XXXXXX in base 2)
            memory[(address[5:0] >> 2)] <= write_data[15:0];    // shift right by 2 to convert from byte to word
        end
    end
    
    assign value = memory[sw];
    
endmodule
