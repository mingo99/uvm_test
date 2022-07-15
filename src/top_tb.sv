module top_tb;

reg clk;
reg rstn;

reg [7:0]   rxd;
reg         rx_dv;

wire [7:0]  txd;
wire        tx_en;

my_if input_if(clk, rstn);
my_if output_if(clk, rstn);

initial begin
    clk = 0;
    forever begin
        #10 clk = ~clk;
    end
end

initial begin
    rstn = 1'b0;
    #100;
    rstn = 1'b1;
end

initial begin
    run_test();
end

initial begin
    uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.drv", "vif", input_if);
    uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.mon", "vif", input_if);
    uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.o_agt.mon", "vif", output_if);
end

`ifdef DUMP_FSDB
    initial
    begin
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars(0,dut);
    end
`endif

dut dut(
    .clk      (clk),
    .rstn     (rstn),
    .rxd      (input_if.data),
    .rx_dv    (input_if.valid),
    .txd      (output_if.data),
    .tx_en    (output_if.valid)
);

endmodule