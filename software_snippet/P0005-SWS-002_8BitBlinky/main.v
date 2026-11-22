// This Verilog file define the Main module of this blinky example.

module main #(
    // Get the default blink divider from a macro defined in apio.ini.
    // In testing, the testbench override it with a very low value.
    parameter integer N = `N
) (
    input  CLK,   // 12MHz clock
    output [7:0] led,

);

  reg [31:0] counter = 0;
  reg [7:0] led_reg = 0;
  

  assign led = led_reg;

  always @(posedge CLK) begin
    if (counter >= N - 1) begin
      counter <= 0;
      led_reg <= led_reg + 1;
    end else begin
      counter <= counter + 1;
    end
  end

endmodule


