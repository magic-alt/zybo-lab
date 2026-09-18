module blink #(
    parameter integer CLK_HZ = 125_000_000
)(
    input  wire clk,
    output reg  led = 1'b0
);
    localparam integer HALF_PERIOD = CLK_HZ / 2;
    integer count = 0;

    always @(posedge clk) begin
        if (count == HALF_PERIOD - 1) begin
            count <= 0;
            led   <= ~led;
        end else begin
            count <= count + 1;
        end
    end
endmodule
