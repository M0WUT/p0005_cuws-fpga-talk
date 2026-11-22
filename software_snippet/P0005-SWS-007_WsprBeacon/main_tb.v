
`timescale 1ns / 1ps

module testbench;

    // DUT signals
    reg CLK = 0;

    wire RF;
    wire [1:0] LED;

    // 12 MHz clock
    always #1 CLK = ~CLK;

    // DUT instantiation
    main #(
        .CLOCK_HZ(12000000),
        .SYMBOL_PERIOD(16),
        .PHASE_WIDTH_BITS(48)
    ) dut (
        .clk(CLK),
        .rf(RF),
        .led(LED)
    );



    // Simulation duration
    initial begin
        $dumpvars(0,testbench);
        #360000;    
        $finish;
    end


endmodule
