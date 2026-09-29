module mips32_data_memory (

    input        clk,

    input        mem_read,
    input        mem_write,

    input [31:0] address,

    input [31:0] write_data,

    output reg [31:0] read_data

);

    // =========================================================
    // DATA MEMORY
    // =========================================================

    reg [31:0] memory [0:255];


    // =========================================================
    // INITIALIZE MEMORY
    // =========================================================

    integer i;

    initial begin

        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'd0;

        // Test data
        memory[25] = 32'd500;

    end


    // =========================================================
    // READ
    // =========================================================

    always @(*) begin

        if (mem_read)
            read_data = memory[address[9:2]];

        else
            read_data = 32'd0;

    end


    // =========================================================
    // WRITE
    // =========================================================

    always @(posedge clk) begin

        if (mem_write)
            memory[address[9:2]] <= write_data;

    end

endmodule