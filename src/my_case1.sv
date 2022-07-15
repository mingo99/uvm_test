class case1_seq extends uvm_sequence #(my_transaction);
    my_transaction trans;

    `uvm_object_utils_begin(case1_seq)
    `uvm_object_utils_end

    function new(string name = "case1_seq");
        super.new(name);
    endfunction: new

    virtual task body();
        if(starting_phase != null) 
            starting_phase.raise_objection(this);
        repeat(100) begin
            `uvm_do_with(trans, {trans.pload.size() == 60;});
        end
        #1000;
        if(starting_phase != null) 
            starting_phase.drop_objection(this);
    endtask: body
endclass: case1_seq

class my_case1 extends base_test;

    `uvm_component_utils_begin(my_case1)
    `uvm_component_utils_end

    function new(string name = "my_case1", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(uvm_object_wrapper)::set(this,
                                                "env.i_agt.sqr.main_phase",
                                                "default_sequence",
                                                case1_seq::type_id::get());
    endfunction: build_phase
endclass: my_case1