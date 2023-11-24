
module counter_5to3 (
  input   wire  i0,
  input   wire  i1, 
  input   wire  i2,
  input   wire  i3,
  input   wire  ci,
  output  wire  s,
  output  wire  c,
  output  wire  co
);

  wire s_temp = i0^i1^i2^i3;
  wire co_temp = i0^i1;
  assign s  = ci^s_temp;
  assign co = (co_temp & i2) | (~co_temp & i0);
  assign c  = (ci&s_temp) | (~s_temp & i3);
endmodule


