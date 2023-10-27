module LCA4bit #(WIDTH=4)(
    input  cin,
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [WIDTH-1:0] s,
    output cout  
);
wire [WIDTH:0] c;
wire [WIDTH-1:0] G;
wire [WIDTH-1:0] P;
assign c[0] = cin;
assign cout = c[WIDTH];

genvar i;
for (i=0; i<=WIDTH-1; i=i+1) begin
    assign P[i] = a[i] ^ b[i];
    assign G[i] = a[i] & b[i];
end

assign c[1] = G[0] + c[0]&P[0];
assign c[2] = G[1] + G[0]&P[1] + c[0]&P[1]&P[0];
assign c[3] = G[2] + G[1]&P[2] + G[0]&P[2]&P[1] + c[0]&P[2]&P[1]&P[0];
assign c[4] = G[3] + G[2]&P[3] + G[1]&P[3]&P[2] + G[0]&P[3]&P[2]&P[1] + c[0]&P[3]&P[2]&P[1]&P[0]; 

endmodule