`timescale 1ns/1ps

module sign_extend_tb;

    reg  [15:0] immediate;
    wire [31:0] extended;

    mips32_sign_extend DUT (
        .immediate(immediate),
        .extended(extended)
    );

    initial begin

        // Positive number: 100
        immediate = 16'd100;

        #5;

        $display("Immediate = %d  Extended = %h",
                 immediate, extended);


        // Positive number: 32767
        immediate = 16'd32767;

        #5;

        $display("Immediate = %d  Extended = %h",
                 immediate, extended);


        // Negative number: -1
        immediate = -16'sd1;

        #5;

        $display("Immediate = %d  Extended = %h",
                 $signed(immediate), extended);


        // Negative number: -4
        immediate = -16'sd4;

        #5;

        $display("Immediate = %d  Extended = %h",
                 $signed(immediate), extended);


        $finish;

    end

endmodule