`timescale 1ns/1ps

module rtype_datapath_tb;

    // =========================================================
    // Instantiate the MIPS32 datapath
    // =========================================================

    mips32_rtype_datapath DUT();


    // =========================================================
    // Clock generation
    // =========================================================

    initial begin

        DUT.clk = 1'b0;

        forever #5 DUT.clk = ~DUT.clk;

    end


    // =========================================================
    // Test
    // =========================================================

    initial begin

        // -----------------------------------------------------
        // RESET
        // -----------------------------------------------------

        DUT.reset = 1'b1;

        #10;

        DUT.reset = 1'b0;


        // -----------------------------------------------------
        // Initialize source registers
        //
        // $t1 = register 9  = 50
        // $t2 = register 10 = 30
        // -----------------------------------------------------

        DUT.REGFILE.registers[9]  = 32'd50;
        DUT.REGFILE.registers[10] = 32'd30;


        // -----------------------------------------------------
        // Wait for ADD instruction
        // -----------------------------------------------------

        #10;


        // -----------------------------------------------------
        // Display results
        // -----------------------------------------------------

        $display("");
        $display("==========================================");
        $display("       MIPS32 R-TYPE DATAPATH TEST");
        $display("==========================================");

        $display("PC           = %h", DUT.pc);

        $display("Instruction  = %h", DUT.instruction);

        $display("Opcode       = %b", DUT.opcode);

        $display("rs           = %d", DUT.rs);

        $display("rt           = %d", DUT.rt);

        $display("rd           = %d", DUT.rd);

        $display("Read Data 1  = %d", DUT.read_data1);

        $display("Read Data 2  = %d", DUT.read_data2);

        $display("ALU Control  = %b", DUT.alu_control);

        $display("ALU Result   = %d", DUT.alu_result);

        $display("RegWrite     = %b", DUT.reg_write);

        $display("$t0 (R8)     = %d",
                 DUT.REGFILE.registers[8]);

        $display("==========================================");


        #10;

        $finish;

    end

endmodule