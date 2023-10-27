module aba_adder #(WIDTH=12)(
    input  cin,
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [WIDTH-1:0] s,
    output cout
);
parameter LCA_WIDTH = 4;

wire [2:0] c;

assign s[WIDTH-LCA_WIDTH-LCA_WIDTH-1:0] = {a[3],a[3],a[3],a[3]};
assign c[0] = a[3];

assign cout = c[2];


LCA4bit LCA4bit_0(
    .cin(c[0]),
    .a(a[WIDTH-1-LCA_WIDTH:WIDTH-LCA_WIDTH-LCA_WIDTH]),
    .b(b[WIDTH-1-LCA_WIDTH:WIDTH-LCA_WIDTH-LCA_WIDTH]),
    .s(s[WIDTH-1-LCA_WIDTH:WIDTH-LCA_WIDTH-LCA_WIDTH]),
    .cout(c[1])
);
LCA4bit LCA4bit_1(
    .cin(c[1]),
    .a(a[WIDTH-1:WIDTH-LCA_WIDTH]),
    .b(b[WIDTH-1:WIDTH-LCA_WIDTH]),
    .s(s[WIDTH-1:WIDTH-LCA_WIDTH]),
    .cout(c[2])
);


endmodule