
//==========================================================================================//


class write_data extends uvm_sequence#(transaction);
  `uvm_object_utils(write_data)
  
  transaction tr;

  function new(string name = "write_data");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op = writed;
        `uvm_info("SEQ", $sformatf("MODE : WRITE DIN : %0d ADDR : %0d ", tr.din, tr.addr), UVM_NONE);
        finish_item(tr);
      end
  endtask
  

endclass


class read_data extends uvm_sequence#(transaction);
  `uvm_object_utils(read_data)
  
  transaction tr;

  function new(string name = "read_data");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op = readd;
        `uvm_info("SEQ", $sformatf("MODE : READ ADDR : %0d ", tr.addr), UVM_NONE);
        finish_item(tr);
      end
  endtask
  

endclass

class reset_dut extends uvm_sequence#(transaction);
  `uvm_object_utils(reset_dut)
  
  transaction tr;

  function new(string name = "reset_dut");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize);
        tr.op = rstdut;
        `uvm_info("SEQ", "MODE : RESET", UVM_NONE);
        finish_item(tr);
      end
  endtask
  

endclass

//==============================================================================//

class write_data extends uvm_sequence#(transaction);
  `uvm_object_utils(write_data)
  
  transaction tr;

  function new(string name = "write_data");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        wait_for_grant(tr);
        start_item(tr);
        assert(tr.randomize);
        tr.rw = 1; // 1 for write
        `uvm_info("SEQ", $sformatf("MODE : WRITE ADDR : %0d DATA : %0d ", tr.addr_to_send, tr.data_to_send), UVM_NONE);
        `uvm_info("SEQ", "WRITE TRANSACTION DETAILS:", UVM_NONE);
        `uvm_info("SEQ", $sformatf("  ADDR : %0d", tr.addr_to_send), UVM_NONE);
        `uvm_info("SEQ", $sformatf("  DATA : %0d", tr.data_to_send), UVM_NONE);
        wait_for_item_done(tr);
        finish_item(tr);
      end
  endtask
  

endclass


class read_data extends uvm_sequence#(transaction);
  `uvm_object_utils(read_data)
  
  transaction tr;

  function new(string name = "read_data");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        wait_for_grant(tr);
        start_item(tr);
        assert(tr.randomize);
        tr.rw = 0; // 0 for read
        `uvm_info("SEQ", $sformatf("MODE : READ ADDR : %0d ", tr.addr_to_send), UVM_NONE);
        `uvm_info("SEQ", "READ TRANSACTION DETAILS:", UVM_NONE);
        `uvm_info("SEQ", $sformatf("  ADDR : %0d", tr.addr_to_send), UVM_NONE);
        wait_for_item_done(tr);
        finish_item(tr);
      end
  endtask
  

endclass

class reset_dut extends uvm_sequence#(transaction);
  `uvm_object_utils(reset_dut)
  
  transaction tr;

  function new(string name = "reset_dut");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        wait_for_grant(tr);
        start_item(tr);
        assert(tr.randomize);
        `uvm_info("SEQ", "MODE : RESET", UVM_NONE);
        `uvm_info("SEQ", "RESET TRANSACTION DETAILS:", UVM_NONE);
        wait_for_item_done(tr);
        finish_item(tr);
      end
  endtask
  

endclass

//=========================================================================================//
