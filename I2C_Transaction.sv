
//======================================================================================//

`include "uvm_macros.svh"
 import uvm_pkg::*;

typedef enum bit [1:0]   {read_data = 0, write_data = 1, rst_dut = 2} opertn_mode;


class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
  opertn_mode op;
  logic rw;
  randc logic [6:0] addr_to_send;
  rand logic [7:0] data_to_send;
  logic [7:0] datard;
  logic done;
         
  constraint addr_c { addr_to_send <= 10;}


  function new(string name = "transaction");
    super.new(name);
  endfunction

endclass : transaction

//==========================================================================================//

`include "uvm_macros.svh"
import uvm_pkg::*;

typedef enum bit [1:0]   {read_data = 0, write_data = 1, rst_dut = 2} opertn_mode;

class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)

  opertn_mode op; // operation mode (read, write, or reset)
  logic rw; // read/write signal (0 for read, 1 for write)
  randc logic [7:0] addr_to_send; // contains 5 bit slave address and 2 bit dummy and last bit says the read/write
  rand logic [7:0] data_to_send;
  logic [7:0] addr_reg_send;
  logic [7:0] addr_reg_read;
  logic [7:0] datard; // received data
  logic done; // transaction completion indicator

  constraint addr_c { addr_to_send[4:0] <= 10; } // constraint on the 5-bit slave address

  function new(string name = "transaction");
    super.new(name);
  endfunction

  // Method to set the operation mode (read, write, or reset)
  function void set_opertn_mode(opertn_mode mode);
    op = mode;
    case (mode)
      read_data: rw = 0;
      write_data: rw = 1;
      rst_dut: rw = 0; // or 1, depending on the reset behavior
    endcase
  endfunction

  // Method to set the address register values
  function void set_addr_regs(logic [7:0] send, logic [7:0] read);
    addr_reg_send = send;
    addr_reg_read = read;
  endfunction

  // Method to get the received data
  function logic [7:0] get_datard();
    return datard;
  endfunction

  // Method to indicate transaction completion
  function void set_done(logic value);
    done = value;
  endfunction

  // Method to print the transaction details
  function void print();
    `uvm_info(get_type_name(), $sformatf("Transaction: op=%s, rw=%b, addr_to_send=%h, data_to_send=%h, datard=%h, done=%b", 
                                         op.name(), rw, addr_to_send, data_to_send, datard, done), UVM_LOW)
  endfunction

endclass : transaction

//========================================================================//
