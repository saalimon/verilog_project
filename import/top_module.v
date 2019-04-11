
module top_module(
    input clk,

    // 7-segment
    output [6:0] seg,
    output dp,
    output [3:0] an,

    // reset button (active high)
    input btnC,

    // display select switch
    input [15:12] sw
    );

    wire rst;
    reset_generator reset(
        .clock(clk),          // system clock
        .reset_in_n(~btnC),   // active low reset input from push button
        .reset_out(rst)       // active high reset signal assert asynchronously but deassert synchronously to clock
        );

    wire [31:0] new_address, current_address;
    program_counter pc(
        .clk(clk),
        .rst(rst),
        .new_address(new_address),
        .current_address(current_address)
    );

    wire [31:0] instruction;
    instruction_memory im(
        //.clk(clk),
        .addr(current_address),
        .data(instruction)
        );

    /* ADD YOUR CODE HERE*/

    wire [1:0]RegDst;
    wire MemRead;
    wire [1:0]MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUsrc;
    wire RegWrite;
    wire Branch;
    wire Jump;
    wire jal;
    wire JumpReg;

    control_unit cu(
        .opcode(instruction[31:26]),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUsrc(ALUsrc),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .Jump(Jump),
        .jal(jal),
        .JumpReg(JumpReg)
        );

    wire [31:0] write_data, read_data_1, read_data_2;
    
    Bit2MUX_5Bit(
            .RegDst(RegDst),
            .rt(instruction[20:16]),
            .rd(instruction[15:11]),
            .Write_Register(write_register)
       );
       
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

    wire [3:0] alu_ctrl;

    alu_control alu_con(
        .alu_op(ALUOp),
        .func(instruction[5:0]),
        .alu_ctrl(alu_ctrl)
        );

    wire [31:0] imm_signed_extended;

    sign_extended se(
        .in(instruction[15:0]),
        .out(imm_signed_extended)
        );

    wire [31:0] alu_result;
    wire zero;



    ALU alu(
        .shamt(instruction[10:6]),
        .a(read_data_1),
        .b(ALUsrc ? imm_signed_extended : read_data_2),
        .alu_con(alu_ctrl),
        .s(alu_result),
        .zero(zero)
        );

    wire [31:0] tmp_new_address;
    assign tmp_new_address = current_address + 4; //$ra
    assign new_address = JumpReg ? read_data_1: Jump ? {tmp_new_address[31:28], (instruction[25:0] << 2)} :
        ((Branch && zero) ? tmp_new_address + (imm_signed_extended << 2) : tmp_new_address);

    /* END */

    wire [31:0] data_from_mem;
    //assign write_data = jal ? tmp_new_address : MemtoReg ? data_from_mem : alu_result;
    mux m(
      .MemtoReg(MemtoReg),
      .data_from_mem(data_from_mem),
      .alu_result(alu_result),
      .PC_4(current_address + 4),
      .write_data(write_data)
      );
      //assign write_data = MemtoReg == 2'b00 ? alu_result : MemtoReg == 2'b01 ? data_from_mem : MemtoReg == 2'b10 ? current_address + 4 : 32'b0;

    data_memory dm(
        .clk(clk),
        .rst(rst),
        .address(alu_result),
        .write_data(read_data_2),
        .read_data(data_from_mem),
        .mem_write(MemWrite),
        .mem_read(MemRead)
        );

    memory_mapped_output mmo(
        .clk(clk),
        .rst(rst),
        // 7-segment
        .seg(seg),
        .dp(dp),
        .an(an),
        // switches
        .sw(sw),
        .address(alu_result), // connect to address of dm
        .write_data(read_data_2), // connect to write_data of dm
        .mem_write(MemWrite)
    );

endmodule
