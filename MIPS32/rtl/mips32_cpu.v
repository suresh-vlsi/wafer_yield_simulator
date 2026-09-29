module mips32_cpu (
    input clk,
    input reset
);

    mips32_datapath CORE (
        .clk(clk),
        .reset(reset)
    );

endmodule