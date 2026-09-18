module top (
    input  wire [3:0] sw,
    input  wire [3:0] btn,
    output wire [3:0] led
);
    assign led = sw ^ btn;
endmodule
