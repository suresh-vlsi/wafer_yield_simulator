`timescale 1ns/1ps

module mips32_cpu_tb;

    reg clk;
    reg reset;


    // =========================================================
    // CPU
    // =========================================================

    mips32_cpu DUT (
        .clk(clk),
        .reset(reset)
    );


    // =========================================================
    // CLOCK
    // =========================================================

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end


    // =========================================================
    // WAVEFORM
    // =========================================================

    initial begin
        $dumpfile("sim/mips32_cpu.vcd");
        $dumpvars(0, DUT);
    end


    // =========================================================
    // TEST
    // =========================================================

    initial begin

        reset = 1'b1;

        #10;

        reset = 1'b0;

        // Allow program to execute
        #300;


        // =====================================================
        // DISPLAY REGISTERS
        // =====================================================

        $display("");
        $display("================================================");
        $display("          MIPS32 CPU FINAL TEST");
        $display("================================================");

        $display("R8  = %h  (%0d)", DUT.CORE.REGFILE.registers[8],
                              DUT.CORE.REGFILE.registers[8]);

        $display("R9  = %h  (%0d)", DUT.CORE.REGFILE.registers[9],
                              DUT.CORE.REGFILE.registers[9]);

        $display("R10 = %h  (%0d)", DUT.CORE.REGFILE.registers[10],
                              DUT.CORE.REGFILE.registers[10]);

        $display("R11 = %h  (%0d)", DUT.CORE.REGFILE.registers[11],
                              DUT.CORE.REGFILE.registers[11]);

        $display("R12 = %h  (%0d)", DUT.CORE.REGFILE.registers[12],
                              DUT.CORE.REGFILE.registers[12]);

        $display("R13 = %h  (%0d)", DUT.CORE.REGFILE.registers[13],
                              DUT.CORE.REGFILE.registers[13]);

        $display("R14 = %h  (%0d)", DUT.CORE.REGFILE.registers[14],
                              DUT.CORE.REGFILE.registers[14]);

        $display("R15 = %h", DUT.CORE.REGFILE.registers[15]);

        $display("R16 = %h", DUT.CORE.REGFILE.registers[16]);

        $display("R17 = %h", DUT.CORE.REGFILE.registers[17]);

        $display("R18 = %h", DUT.CORE.REGFILE.registers[18]);

        $display("R19 = %h", DUT.CORE.REGFILE.registers[19]);

        $display("R20 = %h", DUT.CORE.REGFILE.registers[20]);

        $display("R21 = %h", DUT.CORE.REGFILE.registers[21]);

        $display("R22 = %h", DUT.CORE.REGFILE.registers[22]);

        $display("R24 = %h", DUT.CORE.REGFILE.registers[24]);

        $display("R25 = %h", DUT.CORE.REGFILE.registers[25]);

        $display("R26 = %h", DUT.CORE.REGFILE.registers[26]);

        $display("R27 = %h", DUT.CORE.REGFILE.registers[27]);

        $display("R28 = %h", DUT.CORE.REGFILE.registers[28]);

        $display("R29 = %h", DUT.CORE.REGFILE.registers[29]);

        $display("R31 = %h", DUT.CORE.REGFILE.registers[31]);


        // =====================================================
        // CHECKS
        // =====================================================

        $display("");
        $display("---------------- TEST RESULTS ----------------");


        if (DUT.CORE.REGFILE.registers[10] == 8)
            $display("PASS: ADD");
        else
            $display("FAIL: ADD");


        if (DUT.CORE.REGFILE.registers[11] == 2)
            $display("PASS: SUB");
        else
            $display("FAIL: SUB");


        if (DUT.CORE.REGFILE.registers[12] == 1)
            $display("PASS: AND");
        else
            $display("FAIL: AND");


        if (DUT.CORE.REGFILE.registers[13] == 7)
            $display("PASS: OR");
        else
            $display("FAIL: OR");


        if (DUT.CORE.REGFILE.registers[14] == 6)
            $display("PASS: XOR");
        else
            $display("FAIL: XOR");


        if (DUT.CORE.REGFILE.registers[16] == 0)
            $display("PASS: SLT");
        else
            $display("FAIL: SLT");


        if (DUT.CORE.REGFILE.registers[17] == 1)
            $display("PASS: ANDI");
        else
            $display("FAIL: ANDI");


        if (DUT.CORE.REGFILE.registers[18] == 13)
            $display("PASS: ORI");
        else
            $display("FAIL: ORI");


        if (DUT.CORE.REGFILE.registers[19] == 10)
            $display("PASS: XORI");
        else
            $display("FAIL: XORI");


        if (DUT.CORE.REGFILE.registers[20] == 1)
            $display("PASS: SLTI");
        else
            $display("FAIL: SLTI");


        if (DUT.CORE.REGFILE.registers[21] == 12)
            $display("PASS: SLL");
        else
            $display("FAIL: SLL");


        if (DUT.CORE.REGFILE.registers[22] == 1)
            $display("PASS: SRL");
        else
            $display("FAIL: SRL");


        if (DUT.CORE.REGFILE.registers[25] == 32'hFFFFFFFE)
            $display("PASS: SRA");
        else
            $display("FAIL: SRA");


        if (DUT.CORE.REGFILE.registers[26] == 32'h12340000)
            $display("PASS: LUI");
        else
            $display("FAIL: LUI");


        if (DUT.CORE.REGFILE.registers[27] == 8)
            $display("PASS: LW/SW");
        else
            $display("FAIL: LW/SW");


        if (DUT.CORE.REGFILE.registers[28] == 222)
            $display("PASS: BEQ");
        else
            $display("FAIL: BEQ");


        if (DUT.CORE.REGFILE.registers[29] == 333)
            $display("PASS: BNE");
        else
            $display("FAIL: BNE");


        if (DUT.CORE.REGFILE.registers[23] == 555)
            $display("PASS: JAL/JR");
        else
            $display("FAIL: JAL/JR");


        if (DUT.CORE.REGFILE.registers[31] == 108)
            $display("PASS: JAL link register");
        else
            $display("FAIL: JAL link register");


        $display("");
        $display("================================================");
        $display("          MIPS32 CPU TEST COMPLETE");
        $display("================================================");

        $finish;

    end

endmodule