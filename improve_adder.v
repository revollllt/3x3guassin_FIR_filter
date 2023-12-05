module aba_adder #(parameter WIDTH=12, LCA_WIDTH = 4)(
    input  cin,
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [WIDTH-1:0] s,
    output cout
);

wire [2:0] c;
wire [WIDTH-LCA_WIDTH-LCA_WIDTH-1:0] s0;
wire [LCA_WIDTH-1:0] s1;
wire [LCA_WIDTH-1:0] s2;

// Omit the first four digits
assign s0 = {a[3],a[3],a[3],a[3]};
assign c[0] = a[3];

assign cout = c[2];

/*
LCA4bit LCA4bit_test(
    .cin(cin),
    .a(a[3:0]),
    .b(b[3:0]),
    .s(s0),
    .cout(c[0])
);
*/


LCA4bit LCA4bit_0(
    .cin(c[0]),
    .a(a[WIDTH-1-LCA_WIDTH:WIDTH-LCA_WIDTH-LCA_WIDTH]),
    .b(b[WIDTH-1-LCA_WIDTH:WIDTH-LCA_WIDTH-LCA_WIDTH]),
    .s(s1),
    .cout(c[1])
);
LCA4bit LCA4bit_1(
    .cin(c[1]),
    .a(a[WIDTH-1:WIDTH-LCA_WIDTH]),
    .b(b[WIDTH-1:WIDTH-LCA_WIDTH]),
    .s(s2),
    .cout(c[2])
);
assign s = {s2,s1,s0};

endmodule
