// WSPR transmitter using a GPIO pin of the FPGA on the iCESugar dev board
// It assumes on startup that it is exactly on an even numbered minute
// as it datums time from then

module main#(
  parameter CLOCK_HZ = 12000000,
  parameter SYMBOL_PERIOD = 8192000,
  parameter PHASE_WIDTH_BITS = 32
)(
  input wire clk,
  output wire rf,
  output reg [1:0] led
);
  reg [1:0] wspr_symbols [161:0];

  reg[PHASE_WIDTH_BITS - 1:0] wspr_period_lookup [3:0]; 
  reg[PHASE_WIDTH_BITS - 1:0] phase_increment = 0;

  initial begin
    // Load the contents of wspr_symbols.mem into wspr_symbols
    $readmemh("wspr_symbols.mem", wspr_symbols);

    // 40m WSPR tones 
    // Value = 2^32 * target_freq / CLOCK_HZ 
    // These really should be calculated at compile-time
    // as they can't tolerate changes in PHASE_WIDTH_BITS
    // but I'm in a rush
    wspr_period_lookup[0] = 32'd2519678356;
    wspr_period_lookup[1] = 32'd2519678880;
    wspr_period_lookup[2] = 32'd2519679404;
    wspr_period_lookup[3] = 32'd2519679928;
  end

  reg[7:0] wspr_symbol_index = 0;
  reg[PHASE_WIDTH_BITS-1:0] phase = 0;

  reg tx = 1;
  assign rf = tx ? phase[PHASE_WIDTH_BITS - 1] : 1'b0;


  // Counter used to divide to get symbol period
  reg[31:0] clock_divider_counter = 0;
  // Counter use to time 2 minute period
  reg[31:0] tx_divider_counter = 0;

  always @(posedge clk) begin
    if (tx) begin
      if (clock_divider_counter == SYMBOL_PERIOD - 1) begin
        // Time to change to next symbol
        clock_divider_counter <= 0;
        if (wspr_symbol_index == 161) begin
          // Have sent all symbols - reset for next time
          wspr_symbol_index <= 0;
          tx <= 0;
          clock_divider_counter <= 0;
          phase <= 0;
        end else begin
          // Next symbol
          wspr_symbol_index <= wspr_symbol_index + 1;
        end

        // LED shows which tone is being sent
        led <= wspr_symbols[wspr_symbol_index];

        // wspr_symbol_index is which number tone we're currently sending (0-161)
        // wspr_symbols[wspr_symbol_index] is which of the 4 tones (0-3) currently being sent
        // wspr_period_lookup[wspr_symbols[wspr_symbol_index]] converts tone number into the
        // phase increment for the tone currently being sent
        phase_increment <= wspr_period_lookup[wspr_symbols[wspr_symbol_index]];
      end else begin
        clock_divider_counter <= clock_divider_counter + 1;
      end
      phase <= phase + phase_increment;
    end

    // Separate counter that re-enables tx every 2 minutes
    if (tx_divider_counter == 120 * CLOCK_HZ - 1) begin
      tx <= 1;
      tx_divider_counter <= 0;
    end else begin
      tx_divider_counter <= tx_divider_counter + 1;
    end
  end
endmodule