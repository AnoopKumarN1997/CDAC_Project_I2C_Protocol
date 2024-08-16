class i2c_transaction extends uvm_sequence_item;
   `uvm_object_utils(i2c_transaction)

   // Fields for I2C transaction
   bit [7:0] addr_to_send;   // Address to send (includes slave address and R/W bit)
   bit [7:0] data_to_send;   // Data byte to be sent (for write operations)
   bit rw;                   // Read (1) or Write (0) operation
   bit start;                // Start condition
   bit stop;                 // Stop condition
   bit [7:0] addr_reg_send;  // Register address to write to (if applicable)
   bit [7:0] addr_reg_read;  // Register address to read from (if applicable)

   // Constructor
   function new(string name = "i2c_transaction", uvm_component parent = null);
      super.new(name, parent);
   endfunction


`uvm_object_utils_begin(i2c_transaction)
   `uvm_field_int(addr_to_send, UVM_ALL_ON)
   `uvm_field_int(data_to_send, UVM_ALL_ON)
   `uvm_field_int(rw, UVM_ALL_ON)
   `uvm_field_int(start, UVM_ALL_ON)
   `uvm_field_int(stop, UVM_ALL_ON)
   `uvm_field_int(addr_reg_send, UVM_ALL_ON)
   `uvm_field_int(addr_reg_read, UVM_ALL_ON)
`uvm_object_utils_end


   // Print transaction details
   // function void do_print(uvm_printer printer);
   //    super.do_print(printer);
   //    printer.print_field_int("addr_to_send", addr_to_send, 8);
   //    printer.print_field_int("data_to_send", data_to_send, 8);
   //    printer.print_field_str("rw", rw ? "READ" : "WRITE");
   //    printer.print_field_str("start", start ? "START" : "NO START");
   //    printer.print_field_str("stop", stop ? "STOP" : "NO STOP");
   //    printer.print_field_int("addr_reg_send", addr_reg_send, 8);
   //    printer.print_field_int("addr_reg_read", addr_reg_read, 8);
   // endfunction

   // Constraints
   constraint addr_c {
      addr_to_send >= 8'h00;
      addr_to_send <= 8'hFF;
   }

   constraint data_c {
      data_to_send >= 8'h00;
      data_to_send <= 8'hFF;
   }

   constraint rw_c {
      rw in {0, 1};
   }

   constraint start_stop_c {
      start in {0, 1};
      stop in {0, 1};
   }
endclass

