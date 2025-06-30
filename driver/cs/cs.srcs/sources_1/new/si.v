module si (
    input wire sclk,               // SPI clock (from c_sel)
    input wire rst,                // Asynchronous reset
    input wire start,              // Load and start shifting
    input wire [15:0] din,         // 16-bit input data
    output reg si,                 // Serial data output (MOSI)
    output reg done                // High when done sending all 16 bits
);

    reg [15:0] shift_reg;
    reg [4:0] bit_count;

    always @(posedge sclk or posedge rst) begin
        if (rst) begin
            shift_reg <= 0;
            bit_count <= 0;
            si <= 0;
            done <= 0;
        end else begin
            if (start && bit_count == 0) begin
                shift_reg <= din;
                bit_count <= 16;
                done <= 0;
            end else if (bit_count > 0) begin
                si <= shift_reg[15];
                shift_reg <= shift_reg << 1;
                bit_count <= bit_count - 1;
                if (bit_count == 1)
                    done <= 1;
            end else begin
                done <= 0;
            end
        end
    end
endmodule
