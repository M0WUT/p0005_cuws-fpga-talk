// This Verilog file define the Main module of this blinky example.

module main
(
    input  CLK,   // 12MHz clock
    output reg OUT
);

  reg[7:0] a = 0;
  reg out_reg = 0;
  
  always @(posedge CLK) begin
    if (a == 4) begin
      a <= 0;
      OUT <= 1;
    end else begin
      a <= a + 1;
      OUT <= 0;
    end
    
  end

endmodule


