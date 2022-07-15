class my_scoreboard extends uvm_scoreboard;

    my_transaction exp_queue[$];
    uvm_blocking_get_port #(my_transaction) exp_bp;
    uvm_blocking_get_port #(my_transaction) act_bp;

    `uvm_component_utils_begin(my_scoreboard)
    `uvm_component_utils_end

    function new(string name = "my_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        exp_bp = new("exp_bp", this);
        act_bp = new("act_bp", this);
    endfunction: build_phase

    virtual task main_phase(uvm_phase phase);
        my_transaction get_exp, get_act, tmp_tr;
        bit result;

        fork
            while (1) begin
                exp_bp.get(get_exp);
                exp_queue.push_back(get_exp);
            end
            while (1) begin
                act_bp.get(get_act);
                if(exp_queue.size() > 0) begin
                    tmp_tr = exp_queue.pop_front();
                    result = get_act.compare(tmp_tr);

                    if(result) begin 
                        `uvm_info("my_scoreboard", "The actual pkt is same as expect pkt.", UVM_LOW)
                    end else begin
                        `uvm_error("my_scoreboard", "!!!The actual pkt is same as expect pkt.")
                        $display("the expect pkt is");
                        tmp_tr.print();
                        $display("the actual pkt is");
                        get_act.print();
                    end
                end else begin
                    `uvm_error("my_scoreboard", "Received from DUT, while Expect Queue is empty")
                    $display("the unexpected pkt is");
                    get_act.print();
                end
            end
        join
    endtask: main_phase
endclass: my_scoreboard