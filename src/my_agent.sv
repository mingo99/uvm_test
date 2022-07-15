class my_agent extends uvm_agent;
    my_sequencer    sqr;
    my_driver       drv;
    my_monitor      mon;

    uvm_analysis_port #(my_transaction) ap;

    `uvm_component_utils_begin(my_agent)
    `uvm_component_utils_end

    function new(string name = "my_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(is_active == UVM_ACTIVE) begin
            sqr = my_sequencer::type_id::create("sqr", this);
            drv = my_driver::type_id::create("drv", this);
        end
        mon = my_monitor::type_id::create("mon", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        if(is_active == UVM_ACTIVE) begin
            drv.seq_item_port.connect(sqr.seq_item_export);
        end

        ap = mon.ap;
    endfunction: connect_phase

endclass: my_agent