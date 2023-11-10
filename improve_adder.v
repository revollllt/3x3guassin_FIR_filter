module aba_adder #(parameter WIDTH=17, LCA_WIDTH = 4)(
    input  cin,
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [WIDTH-1:0] s,
    output cout
);

wire [4:0] c;
wire [3:0] s0;
wire [LCA_WIDTH-1:0] s1,s2,s3;
wire s4s;
// Omit the first four digits
// assign s0 = {a[3],a[3],a[3],a[3]};
// assign c[0] = a[3];

assign cout = c[4];

LCA4bit LCA4bit_test(
    .cin(cin),
    .a(a[3:0]),
    .b(b[3:0]),
    .s(s0),
    .cout(c[0])
);


LCA4bit LCA4bit_0(
    .cin(c[0]),
    .a(a[7:4]),
    .b(b[7:4]),
    .s(s1),
    .cout(c[1])
);
LCA4bit LCA4bit_1(
    .cin(c[1]),
    .a(a[11:8]),
    .b(b[11:8]),
    .s(s2),
    .cout(c[2])
);
LCA4bit LCA4bit_2(
    .cin(c[2]),
    .a(a[15:12]),
    .b(b[15:12]),
    .s(s3),
    .cout(c[3])
);
FA FA_out(
    .a(a[WIDTH-1]),
    .b(b[WIDTH-1]),
    .cin(c[3]),
    .s(s4),
    .cout(c[4])
);

assign s = {s4,s3,s2,s1,s0};

endmodule