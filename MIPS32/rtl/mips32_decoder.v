module mips32_decoder (

    input  [31:0] instruction,

    output [5:0] opcode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [5:0] funct,

    output reg [3:0] alu_control,

    output reg       reg_write,
    output reg       use_immediate,

    output reg       mem_read,
    output reg       mem_write,
    output reg       mem_to_reg,

    output reg       branch,
    output reg       branch_ne,

    output reg       jump,
    output reg       jump_reg,
    output reg       link,

    output reg       lui

);

    assign opcode = instruction[31:26];
    assign rs     = instruction[25:21];
    assign rt     = instruction[20:16];
    assign rd     = instruction[15:11];
    assign shamt  = instruction[10:6];
    assign funct  = instruction[5:0];


    always @(*) begin

        // =====================================================
        // DEFAULTS
        // =====================================================

        alu_control   = 4'b0000;

        reg_write     = 1'b0;
        use_immediate = 1'b0;

        mem_read      = 1'b0;
        mem_write     = 1'b0;
        mem_to_reg    = 1'b0;

        branch        = 1'b0;
        branch_ne     = 1'b0;

        jump          = 1'b0;
        jump_reg      = 1'b0;
        link          = 1'b0;

        lui           = 1'b0;


        // =====================================================
        // R-TYPE
        // =====================================================

        if (opcode == 6'b000000) begin

            case (funct)

                // ADD
                6'b100000: begin
                    alu_control = 4'b0010;
                    reg_write   = 1'b1;
                end

                // SUB
                6'b100010: begin
                    alu_control = 4'b0110;
                    reg_write   = 1'b1;
                end

                // AND
                6'b100100: begin
                    alu_control = 4'b0000;
                    reg_write   = 1'b1;
                end

                // OR
                6'b100101: begin
                    alu_control = 4'b0001;
                    reg_write   = 1'b1;
                end

                // XOR
                6'b100110: begin
                    alu_control = 4'b0011;
                    reg_write   = 1'b1;
                end

                // NOR
                6'b100111: begin
                    alu_control = 4'b0100;
                    reg_write   = 1'b1;
                end

                // SLL
                6'b000000: begin
                    alu_control = 4'b0101;
                    reg_write   = 1'b1;
                end

                // SRL
                6'b000010: begin
                    alu_control = 4'b1000;
                    reg_write   = 1'b1;
                end

                // SRA
                6'b000011: begin
                    alu_control = 4'b1001;
                    reg_write   = 1'b1;
                end

                // SLT
                6'b101010: begin
                    alu_control = 4'b0111;
                    reg_write   = 1'b1;
                end

                // JR
                6'b001000: begin
                    jump_reg  = 1'b1;
                    reg_write = 1'b0;
                end

                default: begin
                    reg_write = 1'b0;
                end

            endcase

        end


        // =====================================================
        // ADDI
        // =====================================================

        else if (opcode == 6'b001000) begin

            alu_control   = 4'b0010;
            reg_write     = 1'b1;
            use_immediate = 1'b1;

        end


        // =====================================================
        // SLTI
        // =====================================================

        else if (opcode == 6'b001010) begin

            alu_control   = 4'b0111;
            reg_write     = 1'b1;
            use_immediate = 1'b1;

        end


        // =====================================================
        // ANDI
        // =====================================================

        else if (opcode == 6'b001100) begin

            alu_control   = 4'b0000;
            reg_write     = 1'b1;
            use_immediate = 1'b1;

        end


        // =====================================================
        // ORI
        // =====================================================

        else if (opcode == 6'b001101) begin

            alu_control   = 4'b0001;
            reg_write     = 1'b1;
            use_immediate = 1'b1;

        end


        // =====================================================
        // XORI
        // =====================================================

        else if (opcode == 6'b001110) begin

            alu_control   = 4'b0011;
            reg_write     = 1'b1;
            use_immediate = 1'b1;

        end


        // =====================================================
        // LUI
        // =====================================================

        else if (opcode == 6'b001111) begin

            alu_control   = 4'b1010;
            reg_write     = 1'b1;
            use_immediate = 1'b1;
            lui           = 1'b1;

        end


        // =====================================================
        // LW
        // =====================================================

        else if (opcode == 6'b100011) begin

            alu_control   = 4'b0010;

            reg_write     = 1'b1;
            use_immediate = 1'b1;

            mem_read      = 1'b1;
            mem_to_reg    = 1'b1;

        end


        // =====================================================
        // SW
        // =====================================================

        else if (opcode == 6'b101011) begin

            alu_control   = 4'b0010;

            use_immediate = 1'b1;
            mem_write     = 1'b1;

        end


        // =====================================================
        // BEQ
        // =====================================================

        else if (opcode == 6'b000100) begin

            alu_control = 4'b0110;
            branch      = 1'b1;

        end


        // =====================================================
        // BNE
        // =====================================================

        else if (opcode == 6'b000101) begin

            alu_control = 4'b0110;
            branch      = 1'b1;
            branch_ne   = 1'b1;

        end


        // =====================================================
        // J
        // =====================================================

        else if (opcode == 6'b000010) begin

            jump = 1'b1;

        end


        // =====================================================
        // JAL
        // =====================================================

        else if (opcode == 6'b000011) begin

            jump      = 1'b1;
            link      = 1'b1;
            reg_write = 1'b1;

        end

    end

endmodule