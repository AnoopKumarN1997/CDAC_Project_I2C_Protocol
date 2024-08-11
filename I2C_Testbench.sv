
//========================================================================================//

module tb;  
    
  i2c_i vif();
  
  i2c_mem dut (.clk(vif.clk), .rst(vif.rst), .wr(vif.wr), .addr(vif.addr), .din(vif.din), .datard(vif.datard), .done(vif.done));
  
  initial begin
    vif.clk <= 0;
  end

  always #10 vif.clk <= ~vif.clk;
  
  initial begin
    uvm_config_db#(virtual i2c_i)::set(null, "*", "vif", vif);
    run_test("test");
   end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  
endmodule

//========================================================================================//

module tb;  
    
  i2c_i vif();
  
  i2c_mem dut (.clk(vif.clk), .rst(vif.rst_n), .wr(vif.wr), .datard(vif.dout), .done(vif.done), .addr(vif.addr), .din(vif.din));
  
  initial begin
    #1 vif.clk <= 0;
  end

  always #10 vif.clk <= ~vif.clk;
  
  initial begin
    vif.rst_n <= 1; // Initialize reset signal to active high
    #10 vif.rst_n <= 0; // Deassert reset after 10 time units
  end
  
  initial begin
    uvm_config_db#(virtual i2c_i)::set(null, "*", "vif", vif);
    run_test("test");
   end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  
endmodule

//===================================================================================//

