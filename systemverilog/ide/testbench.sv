module testbench;
  logic arst;
  logic clk;
  logic ce_n;
  logic oe_n;
  logic we_n;
  logic [2:0] address;
  wire logic [7:0] data;
  logic [7:0] val;

  initial begin
    clk = 0;
    we_n = 1;
    oe_n = 1;
    ce_n = 0;
    arst = 1;
    #2.2us;
    arst = 0;

    u_ide.byteCounter = 4;

    // Write LBAs
    address = 3;
    force data = 8'h0;
    ta_write();
    address = 4;
    ta_write();
    address = 5;
    ta_write();

    // Mode = Read
    address = 7;
    force data = 8'h20;
    ta_write();
    release data;
    
    // Read bytes
    address = 0;
    #9us;
    forever begin
      address = 0;
      #3us;
      ta_read();
      #3us;
      address = 7; // status
      @(negedge clk) oe_n = 0;
      @(posedge clk) if((data & 8'h08) == 8'h0) begin
        @(negedge clk);
        oe_n = 1;
        $info("Break");
        break;
      end
      @(negedge clk);
      oe_n = 1;
    end

    #50us $stop;
    #(600 * 2 * 1us) $stop;
  end

  always #1us clk = ~clk;

  task ta_write;
    @(negedge clk) we_n = 0;
    @(negedge clk) we_n = 1;
  endtask
  task ta_read;
    @(negedge clk) oe_n = 0;
    @(negedge clk) oe_n = 1;
  endtask

  ide u_ide(
    .data_in(data),
    .data_out(data),
    .*
  );


  



endmodule

