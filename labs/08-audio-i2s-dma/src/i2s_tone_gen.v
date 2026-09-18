// Minimal I2S playback tone source for the ORIGINAL ZYBO SSM2603.
// MCLK is 12.288 MHz. The codec is configured separately over AXI IIC.
// Output format: Philips I2S, 16-bit samples in 32-bit channel slots.
module i2s_tone_gen (
    input  wire mclk,
    input  wire reset_n,
    output wire ac_bclk,
    output reg  ac_pblrc,
    output reg  ac_pbdat,
    output wire ac_muten
);
    reg [1:0] mclk_div;
    reg [5:0] bit_count;
    reg [5:0] tone_div;

    assign ac_bclk = mclk_div[1];
    assign ac_muten = 1'b1;

    wire bclk_falling = (mclk_div == 2'b11);
    wire signed [15:0] sample = tone_div[5] ? 16'sh5000 : -16'sh5000;
    wire [5:0] slot_bit = bit_count[4:0];

    function automatic sample_bit;
        input [5:0] pos;
        input signed [15:0] value;
        begin
            if (pos == 0)
                sample_bit = 1'b0;              // I2S one-bit delay
            else if (pos <= 16)
                sample_bit = value[16-pos];     // MSB first
            else
                sample_bit = 1'b0;
        end
    endfunction

    always @(posedge mclk or negedge reset_n) begin
        if (!reset_n) begin
            mclk_div <= 2'd0;
            bit_count <= 6'd0;
            tone_div <= 6'd0;
            ac_pblrc <= 1'b0;
            ac_pbdat <= 1'b0;
        end else begin
            mclk_div <= mclk_div + 1'b1;

            if (bclk_falling) begin
                ac_pblrc <= bit_count[5];
                ac_pbdat <= sample_bit(slot_bit, sample);

                if (bit_count == 6'd63) begin
                    bit_count <= 6'd0;
                    tone_div <= tone_div + 1'b1;
                end else begin
                    bit_count <= bit_count + 1'b1;
                end
            end
        end
    end
endmodule
