`timescale 1ns/1ps

module decoder_tb;

    reg [31:0] instruction;

    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;

    wire [3:0] alu_control;
    wire reg_write;


    // ==========================================
    // Instantiate decoder
    // ==========================================

    mips32_decoder DUT (

        .instruction(instruction),

        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),

        .alu_control(alu_control),
        .reg_write(reg_write)

    );


    initial begin

        // ======================================
        // ADD $t0,$t1,$t2
        // ======================================

        instruction = 32'h012A4020;

        #10;

        $display("ADD instruction");
        $display("opcode = %b", opcode);
        $display("rs     = %d", rs);
        $display("rt     = %d", rt);
        $display("rd     = %d", rd);
        $display("shamt  = %d", shamt);
        $display("funct  = %b", funct);
        $display("ALU    = %b", alu_control);
        $display("RegWr  = %b", reg_write);


        // ======================================
        // SUB $t3,$t0,$t1
        // ======================================

        instruction = 32'h01095822;

        #10;

        $display("");
        $display("SUB instruction");
        $display("rs     = %d", rs);
        $display("rt     = %d", rt);
        $display("rd     = %d", rd);
        $display("ALU    = %b", alu_control);
        $display("RegWr  = %b", reg_write);


        // ======================================
        // AND $t4,$t0,$t1
        // ======================================

        instruction = 32'h01096024;

        #10;

        $display("");
        $display("AND instruction");
        $display("rs     = %d", rs);
        $display("rt     = %d", rt);
        $display("rd     = %d", rd);
        $display("ALU    = %b", alu_control);
        $display("RegWr  = %b", reg_write);


        // ======================================
        // OR $t5,$t0,$t1
        // ======================================

        instruction = 32'h01096825;

        #10;

        $display("");
        $display("OR instruction");
        $display("rs     = %d", rs);
        $display("rt     = %d", rt);
        $display("rd     = %d", rd);
        $display("ALU    = %b", alu_control);
        $display("RegWr  = %b", reg_write);


        #10;

        $finish;

    end

endmodule