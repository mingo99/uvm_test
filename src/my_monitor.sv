class my_monitor extends uvm_monitor;

    virtual my_if vif;
    uvm_analysis_port #(my_transaction) ap;

    `uvm_component_utils_begin(my_monitor)
    `uvm_component_utils_end

    function new(string name = "my_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_monitor", "virtual interface is not set for vif!!!")
        ap = new("ap", this);
    endfunction: build_phase

    virtual task main_phase(uvm_phase phase);
        my_transaction tr;

        while (1) begin
            tr = new("tr");
            collect_one_pkt(tr);
            ap.write(tr);
        end
    endtask: main_phase

    virtual task collect_one_pkt(my_transaction tr);
        byte unsigned data_q[$];
        byte unsigned data_array[];
        logic [7:0] data;
        logic valid = 0;
        int data_size;

        while(1) begin
            @(posedge vif.clk);
            if(vif.valid) break;
        end

        `uvm_info("my_monitor", "begin to collect one pkt", UVM_LOW)
        while (vif.valid) begin
            data_q.push_back(vif.data);
            @(posedge vif.clk);
        end

        data_size = data_q.size();
        data_array = new[data_size];
        for (int i=0; i<data_size; ++i) begin
            data_array[i] = data_q[i];
        end

        tr.pload = new[data_size-18];
        data_size = tr.unpack_bytes(data_array)/8;

        `uvm_info("my_monitor", "end collect one pkt", UVM_LOW)

    endtask: collect_one_pkt

endclass: my_monitor