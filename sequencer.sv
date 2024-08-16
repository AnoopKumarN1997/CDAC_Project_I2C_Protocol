class i2c_Sequencer extends uvm_sequencer#(i2c_Packet);

	`uvm_component_utils(i2c_Sequencer)
    
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new
	
endclass : i2c_Sequencer