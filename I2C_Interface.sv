interface i2c_i (
  input  logic clk,
  input  logic rst_n
);

  // I2C bus signals
  logic       scl;  // clock signal
  logic       sda;  // data signal
  logic [6:0] addr;  // address signal
  logic       wr;   // write enable signal
  logic [7:0] din;  // data input signal
  logic [7:0] dout; // data output signal

  // Transaction-level signals
  logic       vif_rst;  // reset signal
  logic [6:0] vif_addr;  // address signal
  logic       vif_wr;  // write enable signal
  logic [7:0] vif_din;  // data input signal

  // Modport for the driver
  modport drv (
    output scl,
    output sda,
    output vif_rst,
    output vif_addr,
    output vif_wr,
    output vif_din
  );

  // Modport for the monitor
  modport mon (
    input scl,
    input sda,
    input vif_rst,
    input vif_addr,
    input vif_wr,
    input vif_din,
    input dout
  );

endinterface : i2c_i