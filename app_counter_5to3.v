
module app_counter_5to3 (
  input   wire  i0,
  input   wire  i1, 
  input   wire  i2,
  input   wire  i3,
  input   wire  ci,
  output  wire  s,
  output  wire  c,
  output  wire  co
);

  wire s_temp1 = ~(i0^i1);
  wire s_temp2 = ~(i2^i3);
  wire co_temp1 = ~(i0|i1);
  wire co_temp2 = ~(i2|i3);
  assign s  = ~((~ci)&(s_temp1|s_temp2));
  assign co = co_temp1|co_temp2;
  assign c  = ~ci;
endmodule


