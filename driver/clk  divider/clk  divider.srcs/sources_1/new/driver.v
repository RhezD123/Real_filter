`timescale 1ns / 1ps

module clock_divider (
    input wire clk,         
    input wire rst,         
    output reg new_clk      
);

    parameter scale = 20;  
    reg [7:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            new_clk <= 0;
        end else begin
            if (counter == (scale - 1)) begin
                counter <= 0;
                new_clk <= ~new_clk; 
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
