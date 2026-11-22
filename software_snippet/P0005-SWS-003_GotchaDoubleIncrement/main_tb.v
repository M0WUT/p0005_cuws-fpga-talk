// A testbench for automatic testing of the module verilog main.
// To run the testbench in batch mode, use the Apio 'test' command.
// To run the testbench with graphical view of the signals, run the 
// Apio 'sim' (as in simulate) command.

`timescale 1ns / 1ps

module testbench;

  // Clock and DUT signals
  reg CLK = 0;
  wire LED1;

  // Instantiate DUT with N = 3 for quick testing
  main dut (
      .CLK (CLK)
      
  );

  // Generate 12 MHz-like clock (approx. 83 ns period)
  always #1 CLK = ~CLK;

  // Expected state tracker
  reg expected_led = 0;


  initial begin
    $dumpvars(0, testbench);
    #10 $finish;
  end

endmodule
