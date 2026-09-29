`timescale 1ns/1ps

module mips32_decoder_tb;

    reg [31:0] instruction;

    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;

    wire [3:0] alu_control;
    wire reg_write;
    wire use_immediate;


    mips32_decoder DUT (

        .instruction(instruction),

        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),

        .alu_control(alu_control),
        .reg_write(reg_write),
        .use_immediate(use_immediate)

    );


    initial begin

        // ==========================================
        // TEST 1
        // ADD $t0,$t1,$t2
        // 012A4020
        // ==========================================

        instruction = 32'h012A4020;

        #10;

        $display("");
        $display("========== ADD ==========");

        $display("Instruction   = %h", instruction);
        $display("Opcode        = %b", opcode);
        $display("rs            = %d", rs);
        $display("rt            = %d", rt);
        $display("rd            = %d", rd);
        $display("Funct         = %b", funct);
        $display("ALU Control   = %b", alu_control);
        $display("RegWrite      = %b", reg_write);
        $display("UseImmediate  = %b", use_immediate);


        // ==========================================
        // TEST 2
        // ADDI $t0,$t1,100
        // 21280064
        // ==========================================

        instruction = 32'h21280064;

        #10;

        $display("");
        $display("========== ADDI ==========");

        $display("Instruction   = %h", instruction);
        $display("Opcode        = %b", opcode);
        $display("rs            = %d", rs);
        $display("rt            = %d", rt);
        $display("Immediate     = %h",
                 instruction[15:0]);

        $display("ALU Control   = %b", alu_control);
        $display("RegWrite      = %b", reg_write);
        $display("UseImmediate  = %b", use_immediate);


        #10;

        $finish;

    end

endmodule