`timescale 1ns/1ps

module mips32_memory_program_tb;

    // =========================================================
    // DATAPATH
    // =========================================================

    mips32_datapath DUT();


    // =========================================================
    // CLOCK
    // =========================================================

    initial begin

        DUT.clk = 1'b0;

        forever #5 DUT.clk = ~DUT.clk;

    end


    // =========================================================
    // TEST
    // =========================================================

    initial begin

        // -----------------------------------------------------
        // RESET
        // -----------------------------------------------------

        DUT.reset = 1'b1;

        #10;

        DUT.reset = 1'b0;


        // -----------------------------------------------------
        // Initialize:
        //
        // $t1 = 100
        // Memory[100] = 500
        // -----------------------------------------------------

        DUT.REGFILE.registers[9] = 32'd100;

        DUT.DATA_MEMORY.memory[25] = 32'd500;


        // =====================================================
        // INSTRUCTION 1
        //
        // LW $t0,0($t1)
        //
        // Memory[100] -> $t0
        // =====================================================

        #10;

        $display("");
        $display("==========================================");
        $display("AFTER LW");
        $display("==========================================");

        $display("PC              = %h",
                 DUT.pc);

        $display("Instruction     = %h",
                 DUT.instruction);

        $display("ALU Result      = %d",
                 DUT.alu_result);

        $display("Memory Data     = %d",
                 DUT.memory_read_data);

        $display("$t0             = %d",
                 DUT.REGFILE.registers[8]);


        // =====================================================
        // INSTRUCTION 2
        //
        // SW $t0,4($t1)
        //
        // $t0 -> Memory[104]
        // =====================================================

        #10;

        $display("");
        $display("==========================================");
        $display("AFTER SW");
        $display("==========================================");

        $display("PC              = %h",
                 DUT.pc);

        $display("Instruction     = %h",
                 DUT.instruction);

        $display("ALU Result      = %d",
                 DUT.alu_result);

        $display("Memory[104]     = %d",
                 DUT.DATA_MEMORY.memory[26]);


        // =====================================================
        // FINAL CHECK
        // =====================================================

        $display("");
        $display("==========================================");
        $display("FINAL RESULTS");
        $display("==========================================");

        $display("$t1             = %d",
                 DUT.REGFILE.registers[9]);

        $display("$t0             = %d",
                 DUT.REGFILE.registers[8]);

        $display("Memory[100]     = %d",
                 DUT.DATA_MEMORY.memory[25]);

        $display("Memory[104]     = %d",
                 DUT.DATA_MEMORY.memory[26]);

        $display("==========================================");


        #10;

        $finish;

    end

endmodule