`timescale 1ns / 1 ps

/* when using the testbench to read the ".txt" file with the samples, 
place the ".txt" file in the sim_1\behav\xsim directory so Vivado can find it. */

module envelope_tb;

  reg clk;
  reg signed [15:0] r_din;
  wire signed [15:0] dout_20k;
  wire signed [15:0] dout_25k;
  wire signed [15:0] dout_30k;
  wire signed [15:0] dout_35k;

  always #50 clk = ~clk;  

  integer fid;
  integer status;
  integer sample;
  integer i;
  integer j = 0;

  localparam num_samples = 1000;

  reg signed [15:0] r_wave_sample [0:num_samples - 1];

  envelope uut (
    .clk(clk),
    .din(r_din),
    .dout_20k(dout_20k),
    .dout_25k(dout_25k),
    .dout_30k(dout_30k),
    .dout_35k(dout_35k)
  );

  initial begin
    clk = 0;
    r_din = 0;

    fid = $fopen("coeffs_20kHz", "r");  // OR coeffs_25kHz/30kHz/35kHz 

    for (i = 0; i < num_samples; i = i + 1) begin
      status = $fscanf(fid, "%d\n", sample);
      r_wave_sample[i] = sample;
    end

    $fclose(fid);

    repeat(num_samples) begin 
      wait (clk == 0); wait (clk == 1);
      r_din = r_wave_sample[j];
      j = j + 1;
    end

    #50000;
    $finish;
  end

endmodule
