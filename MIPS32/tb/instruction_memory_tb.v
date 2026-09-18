`timescale 1ns/1ps

module instruction_memory_tb;

    reg [31:0] address;

    wire [31:0] instruction;


    mips32_instruction_memory DUT (
        .address(address),
        .instruction(instruction)
    );


    initial begin

        // Instruction 0
        address = 32'h00000000;
        #5;

        $display("Address = %h  Instruction = %h",
                 address, instruction);


        // Instruction 1
        address = 32'h00000004;
        #5;

        $display("Address = %h  Instruction = %h",
                 address, instruction);


        // Instruction 2
        address = 32'h00000008;
        #5;

        $display("Address = %h  Instruction = %h",
                 address, instruction);


        // Instruction 3
        address = 32'h0000000C;
        #5;

        $display("Address = %h  Instruction = %h",
                 address, instruction);


        // Instruction 4
        address = 32'h00000010;
        #5;

        $display("Address = %h  Instruction = %h",
                 address, instruction);


        $finish;

    end

endmodule