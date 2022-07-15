module dut(
    input   wire            clk,
    input   wire            rstn,
    input   wire    [7:0]   rxd,
    input   wire            rx_dv,
    output  reg     [7:0]   txd,
    output  reg             tx_en
);

always@(posedge clk or negedge rstn)
begin
    if(~rstn) begin
        txd     <= 8'h00;
        tx_en   <= 1'b0;
    end else begin
        txd     <= rxd;
        tx_en   <= rx_dv;
    end
end

endmodule