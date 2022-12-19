module ram import pa_cpu::*; (
  input logic ce_n,
  input logic oe_n,
  input logic we_n,
  input logic [12:0] address,
  inout logic [7:0] data
);

  logic [7:0] ram [PAGETABLE_RAM_SIZE - 1 : 0];

  assign data = ce_n == 1'b0 && oe_n == 1'b0 && we_n == 1'b1 ? ram[address] : 'z;

  always_ff @(we_n) begin
    if(oe_n == 1'b0) begin
      if(we_n == 1'b0) ram[address] <= data;
    end
  end

endmodule
