`timescale 1ns/1ps

module pc_tb;

    reg clk;
    reg reset;
    reg [31:0] next_pc;

    wire [31:0] pc;


    // Instantiate PC
    mips32_pc DUT (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );


    // Clock
    always #5 clk = ~clk;


    initial begin

        clk = 0;
        reset = 1;
        next_pc = 32'd0;

        // Reset
        #10;

        reset = 0;


        // PC = 4
        next_pc = 32'd4;

        #10;

        $display("PC = %d", pc);


        // PC = 8
        next_pc = 32'd8;

        #10;

        $display("PC = %d", pc);


        // PC = 12
        next_pc = 32'd12;

        #10;

        $display("PC = %d", pc);


        // PC = 16
        next_pc = 32'd16;

        #10;

        $display("PC = %d", pc);


        #10;

        $finish;

    end

endmodule