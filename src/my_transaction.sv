class my_transaction extends uvm_sequence_item;

    rand bit [47:0] dmac;
    rand bit [47:0] smac;
    rand bit [15:0] ether_type;
    rand byte       pload[];
    rand bit [31:0] crc;

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(dmac, UVM_ALL_ON)
        `uvm_field_int(smac, UVM_ALL_ON)
        `uvm_field_int(ether_type, UVM_ALL_ON)
        `uvm_field_array_int(pload, UVM_ALL_ON)
        `uvm_field_int(crc, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint pload_cons{
        pload.size >= 46;
        pload.size <= 1500;
    }

    function bit[31:0] calc_crc();
        return 32'h0;
    endfunction: calc_crc

    function void post_randomize();
        crc = calc_crc;
    endfunction: post_randomize

    function new(string name = "my_transaction");
        super.new(name);
    endfunction: new

    // function void print();
    //     $display("dmac = %0h", dmac);
    //     $display("smac = %0h", smac);
    //     $display("ether_type = %0h", ether_type);
    //     for(int i = 0; i < pload.size; i++) begin
    //         $display("pload[%0d] = %0h", i, pload[i]);
    //     end
    //     $display("crc = %0h", crc);
    // endfunction: print

    // function void copy(my_transaction tr);
    //     if(tr == null)
    //         `uvm_fatal("my_transaction", "tr is null!!!")
    //     dmac = tr.dmac;
    //     smac = tr.smac;
    //     ether_type = tr.ether_type;
    //     pload = new[tr.pload.size()];
    //     for(int i = 0; i < pload.size(); i++) begin
    //         pload[i] = tr.pload[i];
    //     end
    //     crc = tr.crc;
    // endfunction: copy

    // function bit compare(my_transaction tr);
    //     bit result;

    //     if(tr == null)
    //         `uvm_fatal("my_transaction", "tr is null!!!!")

    //     result = ((dmac == tr.dmac) &&
    //             (smac == tr.smac) &&
    //             (ether_type == tr.ether_type) &&
    //             (crc == tr.crc));
    //     if(pload.size() != tr.pload.size())
    //         result = 0;
    //     else 
    //         for(int i = 0; i < pload.size(); i++) begin
    //             if(pload[i] != tr.pload[i])
    //                 result = 0;
    //         end
    //     return result; 
    // endfunction: compare

endclass: my_transaction