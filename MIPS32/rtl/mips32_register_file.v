module mips32_register_file (
    input         clk,
    input         reset,

    input  [4:0]  rs,
    input  [4:0]  rt,

    output [31:0] read_data1,
    output [31:0] read_data2,

    input  [4:0]  write_reg,
    input  [31:0] write_data,
    input         reg_write
);

    reg [31:0] registers [0:31];

integer i;

always @(posedge clk) begin

    if (reset) begin

        for (i = 0; i < 32; i = i + 1)
            registers[i] <= 32'b0;

    end
    else if (reg_write && write_reg != 5'd0) begin

        registers[write_reg] <= write_data;

    end

end

assign read_data1 = (rs == 5'd0) ? 32'b0 : registers[rs];

assign read_data2 = (rt == 5'd0) ? 32'b0 : registers[rt];

endmodule