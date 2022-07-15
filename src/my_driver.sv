class my_driver extends uvm_driver #(my_transaction);

    virtual my_if vif;

    `uvm_component_utils_begin(my_driver)
    `uvm_component_utils_end

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("my_driver", "new is called", UVM_LOW);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("my_driver", "build_phase is called", UVM_LOW);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_driver", "virtual interface is not set for vif!!!")
    endfunction: build_phase

    virtual task main_phase(uvm_phase phase);
        `uvm_info("my_driver", "main_phase is called", UVM_LOW)
        vif.data <= 8'h00;
        vif.valid <= 1'b0;
        while(!vif.rstn)
            @(posedge vif.clk);

        while(1) begin 
            // seq_item_port.get_next_item(req);
            // drive_one_pkt(req);
            // seq_item_port.item_done();
            seq_item_port.try_next_item(req);
            if(req == null) begin
                @(posedge vif.clk);
            end else begin
                drive_one_pkt(req);
                seq_item_port.item_done();
            end
        end
    endtask: main_phase

    virtual task drive_one_pkt(my_transaction tr);
        byte unsigned data_q[];
        int data_size;

        data_size = tr.pack_bytes(data_q)/8;

        `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW)
        repeat(3) @(posedge vif.clk);

        for (int i=0; i<data_size; ++i) begin
            @(posedge vif.clk);
            vif.valid <= 1'b1;
            vif.data <= data_q[i]; 
        end

        @(posedge vif.clk);
        vif.valid <= 1'b0;
        `uvm_info("my_driver", "end drive one pkt", UVM_LOW)

    endtask: drive_one_pkt

endclass: my_driver