
module data_memory(
    input clk,
    input rst,
    
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data,
    input mem_write,
    input mem_read
    );
    
    data_mem mem (
      .a(address >> 2), // convert from byte to word
      .d(write_data),
      .clk(clk),
      .we(mem_write && !(|address[31:12])), // write only if address < 4096 in byte
      .spo(read_data)
    );

endmodule