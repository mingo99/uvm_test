class my_sequencer extends uvm_sequencer #(my_transaction);

    `uvm_component_utils_begin(my_sequencer)
    `uvm_component_utils_end

    function new(string name = "my_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

endclass: my_sequencer