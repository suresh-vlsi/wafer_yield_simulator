module mips32_alu (
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALUControl,
    input  [4:0]  Shamt,

    output reg [31:0] Result,
    output Zero
);

    always @(*) begin

        case (ALUControl)

            // AND
            4'b0000:
                Result = A & B;

            // OR
            4'b0001:
                Result = A | B;

            // ADD
            4'b0010:
                Result = A + B;

            // XOR
            4'b0011:
                Result = A ^ B;

            // NOR
            4'b0100:
                Result = ~(A | B);

            // SLL
            4'b0101:
                Result = B << Shamt;

            // SUB
            4'b0110:
                Result = A - B;

            // SLT
            4'b0111:
                Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;

            // SRL
            4'b1000:
                Result = B >> Shamt;

            // SRA
            4'b1001:
                Result = $signed(B) >>> Shamt;

            // LUI
            4'b1010:
                Result = {B[15:0], 16'b0};

            default:
                Result = 32'd0;

        endcase

    end

    assign Zero = (Result == 32'd0);

endmodule