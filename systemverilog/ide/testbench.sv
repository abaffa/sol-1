module testbench;
  logic arst;
  logic clk;
  logic ce_n;
  logic oe_n;
  logic we_n;
  logic [2:0] address;
  wire logic [7:0] data;

  initial begin
    clk = 0;
    we_n = 1;
    oe_n = 1;
    ce_n = 0;
    arst = 1;
    #2.2us;
    arst = 0;

    address = 7;
    force data = 8'h20;
    we_n = 0;
    @(posedge clk);
    we_n = 1;
    release data;
    address = 0;
    oe_n = 0;

    #(600 * 2 * 1us) $stop;
  end

  always #1us clk = ~clk;

  ide u_ide(
    .data_in(data),
    .data_out(data),
    .*
  );





endmodule
