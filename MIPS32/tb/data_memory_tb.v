`timescale 1ns/1ps

module data_memory_tb;

    reg clk;

    reg mem_read;
    reg mem_write;

    reg [31:0] address;

    reg [31:0] write_data;

    wire [31:0] read_data;


    // =========================================================
    // DUT
    // =========================================================

    mips32_data_memory DUT (

        .clk(clk),

        .mem_read(mem_read),
        .mem_write(mem_write),

        .address(address),

        .write_data(write_data),

        .read_data(read_data)

    );


    // =========================================================
    // CLOCK
    // =========================================================

    initial begin

        clk = 0;

        forever #5 clk = ~clk;

    end


    // =========================================================
    // TEST
    // =========================================================

    initial begin

        mem_read  = 0;
        mem_write = 0;

        address   = 0;
        write_data = 0;


        // -----------------------------------------------------
        // READ MEMORY[100]
        // -----------------------------------------------------

        #2;

        address = 32'd100;

        mem_read = 1;

        #3;

        $display("");
        $display("========== MEMORY READ ==========");

        $display("Address    = %d", address);

        $display("Read Data  = %d", read_data);


        // -----------------------------------------------------
        // WRITE 999 TO MEMORY[104]
        // -----------------------------------------------------

        #5;

        mem_read  = 0;
        mem_write = 1;

        address = 32'd104;

        write_data = 32'd999;


        #5;


        // -----------------------------------------------------
        // READ MEMORY[104]
        // -----------------------------------------------------

        mem_write = 0;
        mem_read  = 1;

        #2;

        $display("");
        $display("========== MEMORY WRITE/READ ==========");

        $display("Address    = %d", address);

        $display("Read Data  = %d", read_data);


        #10;

        $finish;

    end

endmodule