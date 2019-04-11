
module instruction_memory(
    input [31:0] addr,
    output [31:0] data
    );
  
    // address start from 256 to 1024 and the memory has 192 words index by word so we subtract
    // the offset (256) from the address and convert to word before accessing the memory
    wire [31:0] read_addr;
    assign read_addr = (addr - 32'd256) >> 2;
    
    // instantiate Xilinx's block memory primitive
    wire [31:0] mem_data;    
    inst_mem mem (
      .a(read_addr),
      .spo(mem_data)
    );
    
    // data should be 0 for address greater than 1024
    assign data = |addr[31:10] ? 32'd0 : mem_data;
    
endmodule