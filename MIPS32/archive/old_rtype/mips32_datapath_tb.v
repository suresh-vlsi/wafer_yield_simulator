`timescale 1ns/1ps

module mips32_datapath_tb;

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

        DUT.reset = 1'b1;

        #10;

        DUT.reset = 1'b0;

        // Run
        #100;


        // =====================================================
        // DISPLAY
        // =====================================================

        $display("");
        $display("=========================================");
        $display("       MIPS32 JAL + JR TEST");
        $display("=========================================");

        $display("PC       = %h", DUT.pc);
        $display("$t0 (R8) = %d", DUT.REGFILE.registers[8]);
        $display("$t1 (R9) = %d", DUT.REGFILE.registers[9]);
        $display("$ra (R31)= %d", DUT.REGFILE.registers[31]);

        $display("-----------------------------------------");


        // =====================================================
        // CHECK SUBROUTINE
        // =====================================================

        if (DUT.REGFILE.registers[8] == 7)
            $display("PASS: JAL reached subroutine");
        else
            $display("FAIL: JAL");


        // =====================================================
        // CHECK RETURN
        // =====================================================

        if (DUT.REGFILE.registers[9] == 42)
            $display("PASS: JR returned to caller");
        else
            $display("FAIL: JR");


        // =====================================================
        // CHECK RA
        // =====================================================

        if (DUT.REGFILE.registers[31] == 4)
            $display("PASS: $ra contains PC + 4");
        else
            $display("FAIL: $ra");


        // =====================================================
        // FINAL
        // =====================================================

        if ((DUT.REGFILE.registers[8] == 7) &&
            (DUT.REGFILE.registers[9] == 42) &&
            (DUT.REGFILE.registers[31] == 4)) begin

            $display("");
            $display("=========================================");
            $display("       JAL + JR TEST PASSED");
            $display("=========================================");

        end
        else begin

            $display("");
            $display("=========================================");
            $display("       JAL + JR TEST FAILED");
            $display("=========================================");

        end


        $finish;

    end

endmodule