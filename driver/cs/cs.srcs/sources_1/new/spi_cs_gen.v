module spi_cs_gen (
    input wire clk,              // System clock (e.g., 10 MHz)
    input wire rst,
    input wire start,
    input wire [15:0] din,
    output reg cs,
    output wire sclk,
    output reg si,
    output reg done
);

    reg [4:0] bit_count;
    reg [15:0] shift_reg;
    reg [1:0] state;

    localparam IDLE  = 2'b00,
               LOAD  = 2'b01,
               SHIFT = 2'b10,
               DONE  = 2'b11;

    assign sclk = (state == SHIFT) ? clk : 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cs <= 1;
            done <= 0;
            si <= 0;
            bit_count <= 0;
            shift_reg <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    cs <= 1;
                    done <= 0;
                    si <= 0;
                    bit_count <= 0;
                    if (start) begin
                        state <= LOAD;
                    end
                end

                LOAD: begin
                    cs <= 0;
                    shift_reg <= din;
                    bit_count <= 16;
                    state <= SHIFT;
                end

                SHIFT: begin
                    si <= shift_reg[15];
                    shift_reg <= shift_reg << 1;
                    bit_count <= bit_count - 1;
                    if (bit_count == 1)
                        state <= DONE;
                end

                DONE: begin
                    cs <= 1;
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule

