// This Verilog file define the Main module of this blinky example.

module main
(
    input  CLK   // 12MHz clock
);

  reg[7:0] a = 2;
  reg[7:0] b = 6;

  always @(posedge CLK) begin
    a <= a + 1;
    if (b == 6) begin
      a <= a + 1;
    end
  end

endmodule


