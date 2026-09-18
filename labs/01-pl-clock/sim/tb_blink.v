module tb_blink;
  reg clk = 0;
  wire led;
  integer toggles = 0;
  reg last_led = 0;

  blink #(.CLK_HZ(10)) dut(.clk(clk), .led(led));
  always #5 clk = ~clk;

  always @(posedge clk) begin
    if (led != last_led) begin
      toggles = toggles + 1;
      last_led = led;
    end
    if (toggles == 3) begin
      $display("PASS lab01");
      $finish;
    end
  end

  initial begin
    #1000;
    $fatal(1, "timeout");
  end
endmodule
