`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg reset;

    reg [4:0] rs;
    reg [4:0] rt;

    reg [4:0] write_reg;
    reg [31:0] write_data;
    reg reg_write;

    wire [31:0] read_data1;
    wire [31:0] read_data2;


    // Instantiate register file
    mips32_register_file DUT (
        .clk(clk),
        .reset(reset),

        .rs(rs),
        .rt(rt),

        .read_data1(read_data1),
        .read_data2(read_data2),

        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(reg_write)
    );


    // Clock generation
    always #5 clk = ~clk;


    initial begin

        // Initial values
        clk = 0;
        reset = 1;

        rs = 0;
        rt = 0;

        write_reg = 0;
        write_data = 0;
        reg_write = 0;


        // Reset
        #10;

        reset = 0;


        // Write 100 to register 8 ($t0)
        write_reg = 5'd8;
        write_data = 32'd100;
        reg_write = 1;

        #10;


        // Stop writing
        reg_write = 0;


        // Read register 8
        rs = 5'd8;

        #2;

        $display("Register 8 = %d", read_data1);


        // Write 200 to register 9 ($t1)
        write_reg = 5'd9;
        write_data = 32'd200;
        reg_write = 1;

        #10;

        reg_write = 0;


        // Read register 9
        rt = 5'd9;

        #2;

        $display("Register 9 = %d", read_data2);


        // Test register $zero
        rs = 5'd0;

        #2;

        $display("Register 0 = %d", read_data1);


        #10;

        $finish;

    end

endmodule