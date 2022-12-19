module ram import pa_cpu::*; (
  input logic ce_n,
  input logic oe_n,
  input logic we_n,
  inout logic [7:0] data,
  input logic [12:0] address
);

  logic [PAGETABLE_RAM_SIZE - 1 : 0] ram;

  

endmodule
