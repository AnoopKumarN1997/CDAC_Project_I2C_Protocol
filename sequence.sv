
class i2c_base_Sequence extends uvm_sequence #(i2c_Packet);
  ...
  virtual task body();
    ...
    start_item(trans);
    // Send start condition
    send_start_condition();
    // Send address and RW bit
    trans.ADDR = 'h001150aa;
    trans.RW = 'b0; // Write operation
    send_address(trans.ADDR, trans.RW);
    // Send data
    trans.DATA = 'haa005511;
    send_data(trans.DATA);
    // Wait for ACK/NACK response
    wait_for_ack_nack();
    // Send stop condition
    send_stop_condition();
    ...
  endtask : body

  virtual task send_start_condition();
    // Drive SCL low
    vif.scl = 0;
    // Drive SDA low while SCL is low
    vif.sda = 0;
    // Release SDA while SCL is low
    vif.sda = 1;
  endtask : send_start_condition

  virtual task send_address(bit [6:0] addr, bit rw);
    // Send address bits on SDA while toggling SCL
    for (int i = 6; i >= 0; i--) begin
      vif.scl = 0;
      vif.sda = addr[i];
      vif.scl = 1;
    end
    // Send RW bit on SDA while toggling SCL
    vif.scl = 0;
    vif.sda = rw;
    vif.scl = 1;
  endtask : send_address

  virtual task send_data(bit [7:0] data);
    // Send data bits on SDA while toggling SCL
    for (int i = 7; i >= 0; i--) begin
      vif.scl = 0;
      vif.sda = data[i];
      vif.scl = 1;
    end
  endtask : send_data

  virtual task wait_for_ack_nack();
    // Wait for the slave device to respond with an ACK or NACK
    vif.scl = 0;
    vif.sda = 1; // Release SDA
    vif.scl = 1;
    // Sample SDA to check for ACK or NACK
    bit ack_nack = vif.sda;
    if (ack_nack == 0) begin
      `uvm_info(get_full_name(), "Received ACK", UVM_NONE)
    end else begin
      `uvm_error(get_full_name(), "Received NACK")
    end
  endtask : wait_for_ack_nack

  virtual task send_stop_condition();
    // Drive SDA low while SCL is high
    vif.scl = 1;
    vif.sda = 0;
    // Release SDA while SCL is high
    vif.sda = 1;
  endtask : send_stop_condition
endclass : i2c_base_Sequence


// Sequence for Reset Test Sequence
class i2c_Reset_Sequence extends i2c_base_Sequence;

  `uvm_object_utils(i2c_Reset_Sequence)

  i2c_Packet trans;  

  //constructor
  function new(string name="i2c_Reset_Sequence");
    super.new(name);
    `uvm_info(get_full_name(),"-------------------------i2c_Sequence_build-------------------------------",UVM_NONE)
  endfunction : new

  virtual task body();
    repeat(1)
      begin
        `uvm_info(get_full_name(),"-------------------------i2c_Sequence_started-------------------------------",UVM_NONE)
        trans=i2c_Packet::type_id::create("trans");
        start_item(trans);
        reset_test_sequence();
        `uvm_info(get_full_name(),"################################-i2c Generated Packet-############################",UVM_NONE)
        trans.print();
        finish_item(trans);
      end
  endtask : body

  virtual task reset_test_sequence();

    trans.ADDR = 'h001150aa;
    trans.RW = 'b0; // Write operation
    trans.DATA = 'h00; // Reset command

  endtask
 
endclass : i2c_Reset_Sequence


// Sequence for Single Write Sequence
class i2c_Single_Write_Sequence extends i2c_base_Sequence;

  `uvm_object_utils(i2c_Single_Write_Sequence)

  i2c_Packet trans;  

  //constructor
  function new(string name="i2c_Single_Write_Sequence");
    super.new(name);
    `uvm_info(get_full_name(),"-------------------------i2c_Sequence_build-------------------------------",UVM_NONE)
  endfunction : new

  virtual task body();
    repeat(4)
      begin
        `uvm_info(get_full_name(),"-------------------------i2c_Sequence_started-------------------------------",UVM_NONE)
        trans=i2c_Packet::type_id::create("trans");
        start_item(trans);
        Single_Write_sequence();
        `uvm_info(get_full_name(),"################################-i2c Generated Packet-############################",UVM_NONE)
        trans.print();
        finish_item(trans);
      end
  endtask : body

  virtual task Single_Write_sequence();

    trans.ADDR = 'h001150aa;
    trans.RW = 'b0; // Write operation
    trans.DATA = 'haa005511;

  endtask
 
endclass : i2c_Single_Write_Sequence


// Sequence for Read after Write Sequence
class i2c_Single_Read_after_Write_Sequence extends i2c_base_Sequence;

  `uvm_object_utils(i2c_Single_Read_after_Write_Sequence)

  i2c_Packet trans;

  integer i=0 ;

  //constructor
  function new(string name="i2c_Single_Read_after_Write_Sequence");
    super.new(name);
    `uvm_info(get_full_name(),"-------------------------i2c_Sequence_build-------------------------------",UVM_NONE)
  endfunction : new

  virtual task body();
    repeat(50)begin
      `uvm_info(get_full_name(),"-------------------------i2c_Sequence_started-------------------------------",UVM_NONE)
      trans=i2c_Packet::type_id::create("trans");
      start_item(trans);
      Single_Write_sequence();
      single_Read_sequence();
      `uvm_info(get_full_name(),"################################-i2c Generated Packet-############################",UVM_NONE)
      trans.print();
      finish_item(trans);
    end
  endtask : body

  virtual task Single_Write_sequence();

    trans.ADDR = 'h001150aa+i;
    trans.RW = 'b0; // Write operation
    trans.DATA = 'haa005511+i*3;

  endtask

  virtual task single_Read_sequence();

    trans.ADDR = 'h001150aa+i;
    trans.RW = 'b1; // Read operation

    i=i+1;
  endtask
endclass : i2c_Single_Read_after_Write_Sequence


// Sequence for Burst Write Sequence
class i2c_Burst_Write_Sequence extends i2c_base_Sequence;

  `uvm_object_utils(i2c_Burst_Write_Sequence)

  i2c_Packet trans;

  integer i=0 ;

        //constructor
  function new(string name="i2c_Burst_Write_Sequence");
    super.new(name);
    `uvm_info(get_full_name(),"-------------------------i2c_Sequence_build-------------------------------",UVM_NONE)
  endfunction : new

  virtual task body();
    repeat(5)begin
      `uvm_info(get_full_name(),"-------------------------i2c_Sequence_started-------------------------------",UVM_NONE)
      trans=i2c_Packet::type_id::create("trans");
      start_item(trans);
      Single_Write_sequence();
      `uvm_info(get_full_name(),"################################-i2c Generated Packet-############################",UVM_NONE)
      trans.print();
      finish_item(trans);
    end
  endtask : body

  virtual task Single_Write_sequence();

    trans.ADDR = 'h001150aa+i;
    trans.RW = 'b0; // Write operation
    trans.DATA = 'haa005511+i*3;

    i=i+1;
  endtask

endclass : i2c_Burst_Write_Sequence


// Sequence for Burst Read after Write Sequence
class i2c_Burst_Read_after_Write_Sequence extends i2c_base_Sequence;

  `uvm_object_utils(i2c_Burst_Read_after_Write_Sequence)

  i2c_Packet trans;

  integer i=0 ;

  //constructor
  function new(string name="i2c_Burst_Read_after_Write_Sequence");
    super.new(name);
    `uvm_info(get_full_name(),"-------------------------i2c_Sequence_build-------------------------------",UVM_NONE)
  endfunction : new

  virtual task body();
    repeat(100)begin
      `uvm_info(get_full_name(),"-------------------------i2c_Sequence_started-------------------------------",UVM_NONE)
      trans=i2c_Packet::type_id::create("trans");
      start_item(trans);
      Single_Write_sequence();
      single_Read_sequence();
      `uvm_info(get_full_name(),"################################-i2c Generated Packet-############################",UVM_NONE)
      trans.print();
      finish_item(trans);
    end
  endtask : body

  virtual task Single_Write_sequence();

    trans.ADDR = 'h001150aa+i;
    trans.RW = 'b0; // Write operation
    trans.DATA = 'haa005511+i*2;

  endtask

  virtual task single_Read_sequence();

    trans.ADDR = 'h001150aa+i;
    trans.RW = 'b1; // Read operation

    i=i+1;
  endtask
endclass : i2c_Burst_Read_after_Write_Sequence
