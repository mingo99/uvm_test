class my_model extends uvm_component;

    uvm_blocking_get_port #(my_transaction) bp;
    uvm_analysis_port #(my_transaction) ap;

    `uvm_component_utils_begin(my_model)
    `uvm_component_utils_end

    function new(string name = "my_model", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bp = new("bp", this);
        ap = new("ap", this);
    endfunction: build_phase

    virtual task main_phase(uvm_phase phase);
        my_transaction tr;
        my_transaction new_tr;

        while (1) begin
            bp.get(tr);
            new_tr = new("new_tr");
            new_tr.copy(tr);
            `uvm_info("my_model", "get one transaction, copy and print it:", UVM_LOW)
            // new_tr.print();
            ap.write(new_tr);
        end
    endtask: main_phase
endclass: my_model