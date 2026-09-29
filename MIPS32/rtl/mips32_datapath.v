module mips32_datapath (
    input clk,
    input reset
);

    // =========================================================
    // PC
    // =========================================================

    wire [31:0] pc;
    wire [31:0] next_pc;
    wire [31:0] pc_plus_4;


    // =========================================================
    // INSTRUCTION
    // =========================================================

    wire [31:0] instruction;


    // =========================================================
    // INSTRUCTION FIELDS
    // =========================================================

    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;

    wire [15:0] immediate;


    // =========================================================
    // CONTROL
    // =========================================================

    wire [3:0] alu_control;

    wire reg_write;
    wire use_immediate;

    wire mem_read;
    wire mem_write;
    wire mem_to_reg;

    wire branch;
    wire branch_ne;

    wire jump;
    wire jump_reg;

    wire link;
    wire lui;


    // =========================================================
    // REGISTER FILE
    // =========================================================

    wire [31:0] read_data1;
    wire [31:0] read_data2;


    // =========================================================
    // IMMEDIATE
    // =========================================================

    wire [31:0] immediate_value;


    // =========================================================
    // ALU
    // =========================================================

    wire [31:0] alu_input_b;
    wire [31:0] alu_result;
    wire zero;


    // =========================================================
    // MEMORY
    // =========================================================

    wire [31:0] memory_read_data;


    // =========================================================
    // WRITEBACK
    // =========================================================

    wire [31:0] write_back_data;
    wire [4:0] write_register;


    // =========================================================
    // INSTRUCTION FIELDS
    // =========================================================

    assign immediate = instruction[15:0];


    // =========================================================
    // IMMEDIATE EXTENSION
    //
    // ANDI / ORI / XORI -> zero extension
    // Others             -> sign extension
    // =========================================================

    assign immediate_value =
        ((opcode == 6'b001100) ||
         (opcode == 6'b001101) ||
         (opcode == 6'b001110))
        ?
        {16'b0, immediate}
        :
        {{16{immediate[15]}}, immediate};


    // =========================================================
    // ALU INPUT B
    // =========================================================

    assign alu_input_b =
        use_immediate ? immediate_value : read_data2;


    // =========================================================
    // WRITE REGISTER
    //
    // JAL       -> R31
    // I-type    -> rt
    // R-type    -> rd
    // =========================================================

    assign write_register =
        link ? 5'd31 :
        use_immediate ? rt :
        rd;


    // =========================================================
    // WRITEBACK
    // =========================================================

    assign write_back_data =
        link ? pc_plus_4 :
        mem_to_reg ? memory_read_data :
        alu_result;


    // =========================================================
    // PC + 4
    // =========================================================

    assign pc_plus_4 =
        pc + 32'd4;


    // =========================================================
    // BRANCH
    // =========================================================

    assign branch_taken =
        branch &&
        (
            (branch_ne && !zero) ||
            (!branch_ne && zero)
        );


    // =========================================================
    // BRANCH WIRES
    // =========================================================

    wire [31:0] branch_offset;
    wire [31:0] branch_target;

    assign branch_offset =
        immediate_value << 2;

    assign branch_target =
        pc_plus_4 + branch_offset;


    // =========================================================
    // JUMP TARGET
    // =========================================================

    wire [31:0] jump_target;

    assign jump_target = {
        pc_plus_4[31:28],
        instruction[25:0],
        2'b00
    };


    // =========================================================
    // JR TARGET
    // =========================================================

    wire [31:0] jump_reg_target;

    assign jump_reg_target =
        read_data1;


    // =========================================================
    // NEXT PC
    //
    // JR
    // J / JAL
    // BEQ / BNE
    // PC + 4
    // =========================================================

    assign next_pc =
        jump_reg ?
            jump_reg_target :
        jump ?
            jump_target :
        branch_taken ?
            branch_target :
            pc_plus_4;


    // =========================================================
    // PC
    // =========================================================

    mips32_pc PC_UNIT (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );


    // =========================================================
    // INSTRUCTION MEMORY
    // =========================================================

    mips32_instruction_memory IMEM (
        .address(pc),
        .instruction(instruction)
    );


    // =========================================================
    // DECODER
    // =========================================================

    mips32_decoder DECODER (
        .instruction(instruction),

        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),

        .alu_control(alu_control),

        .reg_write(reg_write),
        .use_immediate(use_immediate),

        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),

        .branch(branch),
        .branch_ne(branch_ne),

        .jump(jump),
        .jump_reg(jump_reg),

        .link(link),
        .lui(lui)
    );


    // =========================================================
    // REGISTER FILE
    // =========================================================

    mips32_register_file REGFILE (
        .clk(clk),
        .reset(reset),

        .rs(rs),
        .rt(rt),

        .read_data1(read_data1),
        .read_data2(read_data2),

        .write_reg(write_register),
        .write_data(write_back_data),

        .reg_write(reg_write)
    );


    // =========================================================
    // ALU
    // =========================================================

    mips32_alu ALU (
        .A(read_data1),
        .B(alu_input_b),

        .ALUControl(alu_control),
        .Shamt(shamt),

        .Result(alu_result),
        .Zero(zero)
    );


    // =========================================================
    // DATA MEMORY
    // =========================================================

    mips32_data_memory DATA_MEMORY (
        .clk(clk),

        .mem_read(mem_read),
        .mem_write(mem_write),

        .address(alu_result),
        .write_data(read_data2),

        .read_data(memory_read_data)
    );

endmodule