// pll.v
//
// Copyright (C) 2020 Dan Rodrigues <danrr.gh.oss@gmail.com>
//
// SPDX-License-Identifier: MIT

`default_nettype none

module pll #(
    parameter ENABLE_FAST_CLK = 1
) (
    // verilator lint_off UNUSED
    input clk_12m,
    // verilator lint_on UNUSED

    output locked,
    output clk_1x /* verilator clocker */,
    output clk_2x /* verilator clocker */
);
    localparam PLL_DIVR_25M = 4'b0000;
    localparam PLL_DIVF_25M = 7'b1000010;
    localparam PLL_DIVQ_25M = 7'b101;

    localparam PLL_DIVR_33M = 4'b0000;
    localparam PLL_DIVF_33M = 7'b0101100;
    localparam PLL_DIVQ_33M = 7'b100;

    localparam PLL_DIVR = ENABLE_FAST_CLK ? PLL_DIVR_33M : PLL_DIVR_25M;
    localparam PLL_DIVF = ENABLE_FAST_CLK ? PLL_DIVF_33M : PLL_DIVF_25M;
    localparam PLL_DIVQ = ENABLE_FAST_CLK ? PLL_DIVQ_33M : PLL_DIVQ_25M;

`ifndef VERILATOR
    SB_PLL40_2F_PAD #(
        .FEEDBACK_PATH("SIMPLE"),
        .PLLOUT_SELECT_PORTA("GENCLK_HALF"),
        .PLLOUT_SELECT_PORTB("GENCLK"),
        .DIVR(PLL_DIVR),
        .DIVF(PLL_DIVF),
        .DIVQ(PLL_DIVQ),
        .FILTER_RANGE(3'b001)
    ) pll (
        .LOCK(locked),
        .RESETB(1'b1),
        .BYPASS(1'b0),
        .PACKAGEPIN(clk_12m),
        .PLLOUTGLOBALA(clk_1x),
        .PLLOUTGLOBALB(clk_2x)
    );
`else
    // these are directly assigned to in the verilator testbench
    reg clk_1x_r = 0;

    // not 12M in sim*
    // reg clk_2x_r; // = 0;
    wire clk_2x_r = clk_12m;

    assign clk_1x = clk_1x_r;
    assign clk_2x = clk_2x_r;
    assign locked = 1;

    always @(posedge clk_12m) begin
    // always @(posedge clk_2x_r) begin
        clk_1x_r = !clk_1x_r;
    end

`endif

endmodule
