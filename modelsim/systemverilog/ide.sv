module ide_drive(
  input logic arst,
  input logic clk,
  input logic ce_n,
  input logic oe_n,
  input logic we_n,
  input logic [2:0] address,
  input logic [7:0] data_in,

  output logic [7:0] data_out
);
  import pa_testbench::*;
  
  typedef enum logic [2:0] {
    RESET_ST = 3'b000,
    BUSY_ST,
    READ_ST,
    WRITE_ST,
    READ_COMPLETE_ST,
    WRITE_COMPLETE_ST
  } t_ideState;

  t_ideState currentState;
  t_ideState nextState;

  logic [7:0] LBA [2:0];
  logic [8:0] byteCounter;
  logic [7:0] mem [1025 * KB];
  logic [7:0] registers [7:0];

  always @(posedge clk, posedge arst) begin
    if(arst) begin
      for(byte i = 0; i < 8; i++) registers[i] = '0;
    end else begin
      if(!we_n && !ce_n) registers[address] = data_in;
    end
  end

  assign data_out = !ce_n && !oe_n && we_n ? registers[address] : 'z;
  assign LBA = registers[5:3];

// State machine
  always_ff @(posedge clk, posedge arst) begin
    if(arst) begin
      byteCounter <= '0;
    end
    else case(currentState)
      RESET_ST: begin
        if(registers[7] == 8'h20) begin
          currentState <= READ_ST;
          byteCounter <= 9'h1;
          registers[0] <= mem[{LBA[2], LBA[1], LBA[0]}];
        end
        else if(registers[7] == 8'h30) begin
          currentState <= WRITE_ST;
          byteCounter <= 9'h1;
          registers[0] <= mem[{LBA[2], LBA[1], LBA[0]}];
        end
      end
      READ_ST: begin
        if(byteCounter == 9'd512) currentState <= READ_COMPLETE_ST;
        else begin
          currentState <= READ_ST;
          byteCounter <= byteCounter + 9'd1;
        end
        registers[0] <= mem[{LBA[2], LBA[1], LBA[0]} + byteCounter];
      end
    endcase
  end



endmodule
