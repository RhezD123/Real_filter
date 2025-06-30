`timescale 1ns / 1ps

module envelope (
  input clk,
  input signed [15:0] din,
  output signed [15:0] dout_20k,
  output signed [15:0] dout_25k,
  output signed [15:0] dout_30k,
  output signed [15:0] dout_35k
);

  filter20kHz f20k (
    .clk(clk),
    .din(din),
    .dout(dout_20k)
  );

  filter25kHz f25k (
    .clk(clk),
    .din(din),
    .dout(dout_25k)
  );

  filter30kHz f30k (
    .clk(clk),
    .din(din),
    .dout(dout_30k)
  );

  filter35kHz f35k (
    .clk(clk),
    .din(din),
    .dout(dout_35k)
  );

endmodule
