`timescale 1ns / 1ps

module tb;

    // Testbench signals
    reg clk;        // 200 MHz input clock
    reg rst;        // Reset
    wire new_clk;   // Output from clock divider (5 MHz target)

    // Instantiate the Unit Under Test (UUT)
    clock_divider #(.scale(20)) uut (
        .clk(clk),
        .rst(rst),
        .new_clk(new_clk)
    );

    // Generate a 200 MHz clock (5 ns period)
    initial begin
        clk = 0;
        forever #2.5 clk = ~clk;  // Toggle every 2.5 ns → 200 MHz clock
    end

    // Simulation control
    initial begin
        rst = 1;
        #20;         // Hold reset high for 20 ns
        rst = 0;

        // Let the simulation run long enough to observe output toggling
        #1000;

        $finish;
    end

    // Optional: Display waveform transitions in console
    initial begin
        $display("Time (ns) | new_clk");
        $monitor("%t | %b", $time, new_clk);
    end

endmodule
