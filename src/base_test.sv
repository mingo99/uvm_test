class base_test extends uvm_test;
    my_env env;

    `uvm_component_utils_begin(base_test)
    `uvm_component_utils_end

    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = my_env::type_id::create("env", this);
    endfunction: build_phase

    function void report_phase(uvm_phase phase);
        uvm_report_server server;
        int err_num;

        server = get_report_server();
        err_num = server.get_severity_count(UVM_ERROR);

        if (err_num != 0) begin
            $display("TEST CASE FAILED");
        end else begin
            $display("TEST CASE PASSED");
        end
    endfunction: report_phase

endclass: base_test