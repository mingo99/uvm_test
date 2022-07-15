class my_env extends uvm_env;

    my_agent i_agt;
    my_agent o_agt;
    my_model mdl;
    my_scoreboard scb;

    uvm_tlm_analysis_fifo #(my_transaction) agt_mdl_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) agt_scb_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) mdl_scb_fifo;

    `uvm_component_utils_begin(my_env)
    `uvm_component_utils_end

    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        i_agt = my_agent::type_id::create("i_agt", this);
        o_agt = my_agent::type_id::create("o_agt", this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt.is_active = UVM_PASSIVE;
        mdl = my_model::type_id::create("mdl", this);
        scb = my_scoreboard::type_id::create("scb", this);

        agt_mdl_fifo = new("agt_mdl_fifo", this);
        agt_scb_fifo = new("agt_scb_fifo", this);
        mdl_scb_fifo = new("mdl_scb_fifo", this);

        // uvm_config_db#(uvm_object_wrapper)::set(this,
        //                                     "i_agt.sqr.main_phase",
        //                                     "default_sequence",
        //                                     my_sequence::type_id::get());
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        i_agt.ap.connect(agt_mdl_fifo.analysis_export);
        mdl.bp.connect(agt_mdl_fifo.blocking_get_export);

        o_agt.ap.connect(agt_scb_fifo.analysis_export);
        scb.act_bp.connect(agt_scb_fifo.blocking_get_export);

        mdl.ap.connect(mdl_scb_fifo.analysis_export);
        scb.exp_bp.connect(mdl_scb_fifo.blocking_get_export);
    endfunction: connect_phase

endclass: my_env