module tb_top;
  reg  [3:0] sw;
  reg  [3:0] btn;
  wire [3:0] led;

  top dut(.sw(sw), .btn(btn), .led(led));

  initial begin
    sw = 4'b0000; btn = 4'b0000; #1;
    if (led !== 4'b0000) $fatal(1, "case0");
    sw = 4'b1010; btn = 4'b0011; #1;
    if (led !== 4'b1001) $fatal(1, "case1");
    sw = 4'b1111; btn = 4'b1111; #1;
    if (led !== 4'b0000) $fatal(1, "case2");
    $display("PASS lab00");
    $finish;
  end
endmodule
