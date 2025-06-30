`timescale 1ns / 1ps

module tb_spi_cs_gen;

    reg clk;
    reg rst;
    reg start;
    reg [15:0] din;
    wire cs, sclk, si, done;

    spi_cs_gen uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .din(din),
        .cs(cs),
        .sclk(sclk),
        .si(si),
        .done(done)
    );

    // Generate 10 MHz clock
    initial begin
        clk = 0;
        forever #50 clk = ~clk;  // 100 ns period
    end

    // Test scenario
    initial begin
        rst = 1;
        start = 0;
        din = 16'b1011000100101101;  // Example test pattern
        #100;

        rst = 0;
        #100;

        start = 1;
        #100;
        start = 0;

        #5000;
        $finish;
    end

    // Output to console
    initial begin
        $display("Time\tcs\tsclk\tsi\tdone");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, cs, sclk, si, done);
    end

endmodule



