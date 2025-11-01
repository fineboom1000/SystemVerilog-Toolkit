// Testbench for 4-digit hex-to-7-segment display
module hex_to_sseg_test(
    input  logic clk,           // clock for time-multiplexing
    input  logic [7:0] sw,     // 8-bit input switches
    output logic [3:0] an,     // anode signals for 4 digits
    output logic [7:0] sseg    // 7-segment + decimal point (active low)
);

    // Internal signals for segment patterns of each digit
    logic [7:0] led0, led1, led2, led3;

    // Instantiate four hex-to-7seg decoders
    // Each instance converts a 4-bit nibble to 7-segment outputs

    // LSBs, no decimal point
    hex_to_sseg sseg_unit_0(
        .hex(sw[3:0]),
        .dp(1'b0),
        .sseg(led0)
    );

    // MSBs, no decimal point
    hex_to_sseg sseg_unit_1(
        .hex(sw[7:4]),
        .dp(1'b0),
        .sseg(led1)
    );

    // LSBs, decimal point on
    hex_to_sseg sseg_unit_2(
        .hex(sw[3:0]),
        .dp(1'b1),
        .sseg(led2)
    );

    // MSBs, decimal point on
    hex_to_sseg sseg_unit_3(
        .hex(sw[7:4]),
        .dp(1'b1),
        .sseg(led3)
    );

    // Instantiate 4-digit display multiplexing module
    // Time-multiplexes the 4 digits onto a single 7-segment bus
    disp_mux disp_unit(
        .clk(clk),
        .reset(1'b0),
        .in0(led0),
        .in1(led1),
        .in2(led2),
        .in3(led3),
        .an(an),
        .sseg(sseg)
    );

endmodule
