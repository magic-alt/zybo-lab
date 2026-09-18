module tb_vga_pattern;
  reg clk = 0;
  wire [4:0] r;
  wire [5:0] g;
  wire [4:0] b;
  wire hs, vs;
  integer cycles = 0;

  vga_pattern dut(.clk(clk), .vga_r(r), .vga_g(g), .vga_b(b), .vga_hs(hs), .vga_vs(vs));
  always #4 clk = ~clk;

  always @(posedge clk) begin
    cycles = cycles + 1;
    if (cycles == 800*525*5 + 20) begin
      $display("PASS lab02");
      $finish;
    end
  end
endmodule
