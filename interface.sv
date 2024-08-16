interface i2c_i ();
	logic 		 sda_out;
    logic        scl;
 //   logic        clk2mhz_dummy;                         // Reference clock for utilizing in slave unit
    logic        rw;
    logic        sda_in;
    logic        clk100mhz;                             // Why 2 Mhz, and not use 100 Mhz directly?
    logic        res;
    logic [7:0]  data_to_send; 
    logic [7:0]  addr_to_send;                           // contains 5 bit slave address and 2 bit dummy and                                                         // last bit says the read/write
    logic [7:0]  addr_reg_send;
    logic [7:0]  addr_reg_read;

endinterface : i2c_i
