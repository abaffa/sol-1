module alu(
  input logic [7:0] a,
  input logic [7:0] b,
  input logic cf_in,
  input logic [3:0] op,
  input logic mode,

  output logic [7:0] alu_out,
  output logic cf_out
);

  logic [7:0] c, cn;

  assign c = {{7{1'b0}}, cf_in};
  assign cn = {{7{1'b0}}, ~cf_in};

  always_comb begin
    case(op)
      4'b0000: {cf_out, alu_out} = mode ? ~a : a + cn;
      4'b0001: {cf_out, alu_out} = mode ? ~(a | b) : a | b + cn;
      4'b0010: {cf_out, alu_out} = mode ? ~a & b : (a | ~b) + cn;
      4'b0011: {cf_out, alu_out} = mode ? '0 : -1 + cn;
      4'b0100: {cf_out, alu_out} = mode ? ~(a & b) : a + (a & ~b) + cn;
      4'b0101: {cf_out, alu_out} = mode ? ~b : (a | b) + (a & ~b) + cn;
      4'b0110: {cf_out, alu_out} = mode ? a ^ b : a - b - cn;
      4'b0111: {cf_out, alu_out} = mode ? a & ~b : a & ~b - cn;
      4'b1000: {cf_out, alu_out} = mode ? ~a | b : a + (a & b) + c;
      4'b1001: {cf_out, alu_out} = mode ? ~(a ^ b) : a + b + c;
      4'b1010: {cf_out, alu_out} = mode ? b : a + b + c;
      4'b1011: {cf_out, alu_out} = mode ? a & b : a & b - cn;
      4'b1100: {cf_out, alu_out} = mode ? a & b : a & b - cn;
      4'b1101: {cf_out, alu_out} = mode ? a | ~b : (a | b) + a + c;
      4'b1110: {cf_out, alu_out} = mode ? a | b : (a | ~b) + a + c;
      4'b1111: {cf_out, alu_out} = mode ? a : a - cn;
    endcase
    
  end


endmodule
