module vga_pattern(
    input  wire       clk,
    output reg  [4:0] vga_r = 0,
    output reg  [5:0] vga_g = 0,
    output reg  [4:0] vga_b = 0,
    output reg        vga_hs = 1,
    output reg        vga_vs = 1
);
    reg [2:0] div5 = 0;
    reg [9:0] h = 0;
    reg [9:0] v = 0;

    wire active = (h < 640) && (v < 480);

    always @(posedge clk) begin
        if (div5 == 4) begin
            div5 <= 0;

            if (h == 799) begin
                h <= 0;
                if (v == 524)
                    v <= 0;
                else
                    v <= v + 1;
            end else begin
                h <= h + 1;
            end

            vga_hs <= ~((h >= 656) && (h < 752));
            vga_vs <= ~((v >= 490) && (v < 492));

            if (!active) begin
                vga_r <= 0;
                vga_g <= 0;
                vga_b <= 0;
            end else if (h < 80) begin
                {vga_r, vga_g, vga_b} <= {5'h1F, 6'h00, 5'h00};
            end else if (h < 160) begin
                {vga_r, vga_g, vga_b} <= {5'h00, 6'h3F, 5'h00};
            end else if (h < 240) begin
                {vga_r, vga_g, vga_b} <= {5'h00, 6'h00, 5'h1F};
            end else if (h < 320) begin
                {vga_r, vga_g, vga_b} <= {5'h1F, 6'h3F, 5'h00};
            end else if (h < 400) begin
                {vga_r, vga_g, vga_b} <= {5'h1F, 6'h00, 5'h1F};
            end else if (h < 480) begin
                {vga_r, vga_g, vga_b} <= {5'h00, 6'h3F, 5'h1F};
            end else if (h < 560) begin
                {vga_r, vga_g, vga_b} <= {5'h1F, 6'h3F, 5'h1F};
            end else begin
                {vga_r, vga_g, vga_b} <= {5'h0F, 6'h1F, 5'h0F};
            end
        end else begin
            div5 <= div5 + 1;
        end
    end
endmodule
