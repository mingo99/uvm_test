class case0_seq extends uvm_sequence #(my_transaction);
    my_transaction trans;

    `uvm_object_utils_begin(case0_seq)
    `uvm_object_utils_end

    function new(string name = "case0_seq");
        super.new(name);
    endfunction: new

    virtual task body();
        if(starting_phase != null) 
            starting_phase.raise_objection(this);
        repeat(10) begin
            `uvm_do(trans)
        end
        #1000;
        if(starting_phase != null) 
            starting_phase.drop_objection(this);
    endtask: body
endclass: case0_seq

class my_case0 extends base_test;

    `uvm_component_utils_begin(my_case0)
    `uvm_component_utils_end

    function new(string name = "my_case0", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(uvm_object_wrapper)::set(this,
                                                "env.i_agt.sqr.main_phase",
                                                "default_sequence",
                                                case0_seq::type_id::get());
    endfunction: build_phase
endclass: my_case0