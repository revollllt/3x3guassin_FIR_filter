module computing_block
#(parameter DATA_WIDTH = 8)
(
input [DATA_WIDTH-1:0] line0_data0,
input [DATA_WIDTH-1:0] line0_data1,
input [DATA_WIDTH-1:0] line0_data2,
input [DATA_WIDTH-1:0] line1_data0,
input [DATA_WIDTH-1:0] line1_data1,
input [DATA_WIDTH-1:0] line1_data2,
input [DATA_WIDTH-1:0] line2_data0,
input [DATA_WIDTH-1:0] line2_data1,
input [DATA_WIDTH-1:0] line2_data2,
input  [3:0]           corner_type,
output [DATA_WIDTH-1:0] data_out
);

//    parameter         corner_flag_start     = 1;
//    parameter         corner_right_start    = 2;
//    parameter         corner_flag_leftline  = 3;
//    parameter         corner_flag_rigntline = 4;
//    parameter         corner_flag_leftend   = 5;
//    parameter         corner_flag_rigntend  = 6;
//    parameter         corner_flag_lastline  = 7;
//    parameter         total_cross           = 8;

reg [4:0]   coff_0  [2:0];  // a sign_bit is added to the front of the number
reg [4:0]   coff_1  [2:0];
reg [4:0]   coff_2  [2:0];


// guassin kernal
//     [1 2 1]
// 1/16[2 4 2]
//     [1 2 1]

// [-1 0 -1]
// [ 0 4  0]
// [-1 0 -1]

always@(*) begin
case (corner_type)
4'd0 :  begin           // initial//
        coff_0[0] <= 0;
        coff_0[1] <= 0;
        coff_0[2] <= 0;
        coff_1[0] <= 0;
        coff_1[1] <= 0;
        coff_1[2] <= 0;
        coff_2[0] <= 0;
        coff_2[1] <= 0;
        coff_2[2] <= 0;
        end
4'd1 :  begin           // start//
        coff_0[0] <= 5'b10001;
        coff_0[1] <= 0;
        coff_0[2] <= 0;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 0;
        coff_2[1] <= 0;
        coff_2[2] <= 0;
        end
4'd2 :  begin           // right start//
        coff_0[0] <= 0;
        coff_0[1] <= 0;
        coff_0[2] <= 5'b10001;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 0;
        coff_2[1] <= 0;
        coff_2[2] <= 0;
        end
4'd3 :  begin           // the left beginning//
        coff_0[0] <= 5'b10001;
        coff_0[1] <= 0;
        coff_0[2] <= 0;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 5'b10001;
        coff_2[1] <= 0;
        coff_2[2] <= 0;
        end
4'd4 :  begin           // the right boarder//
        coff_0[0] <= 0;
        coff_0[1] <= 0;
        coff_0[2] <= 5'b10001;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 0;
        coff_2[1] <= 0;
        coff_2[2] <= 5'b10001;
        end
4'd5 :  begin           // the leftend//
        coff_0[0] <= 0;
        coff_0[1] <= 0;
        coff_0[2] <= 0;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 5'b10001;
        coff_2[1] <= 0;
        coff_2[2] <= 0;
        end
4'd6 :  begin           // the rigntend//
        coff_0[0] <= 0;
        coff_0[1] <= 0;
        coff_0[2] <= 0;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 0;
        coff_2[1] <= 0;
        coff_2[2] <= 5'b10001;
        end
default: begin           // the total 3*3//
        coff_0[0] <= 5'b10001;
        coff_0[1] <= 0;
        coff_0[2] <= 5'b10001;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 5'b10001;
        coff_2[1] <= 0;
        coff_2[2] <= 5'b10001;
        end
endcase
end 

wire   [aba_adder_WIDTH+sign_bit-1:0] data_out_r;
localparam aba_adder_WIDTH = 16;
localparam sign_bit = 1;
wire   [aba_adder_WIDTH+sign_bit-1:0] mul_out [8:0];
wire   [aba_adder_WIDTH+sign_bit-1:0] complement_code [8:0];
// store multiply answer in mul_out 

// dadda_tree
wire [15:0] dadda_result [8:0];

genvar k;
generate
    begin:COMPLEMENT_ADDER
        for (k=0; k<9; k=k+1) begin
                aba_adder aba_adder_complement(
                        .cin(1'b1),
                        .a(~{1'b0,dadda_result[k]}),
                        .b(17'b0),
                        .s(complement_code[k]),
                        .cout()
                );
        end
    end
endgenerate

assign mul_out[0] = (coff_0[0][4]==1) ? complement_code[0] : {1'b0,dadda_result[0]};
assign mul_out[1] = (coff_0[1][4]==1) ? complement_code[1] : {1'b0,dadda_result[1]};
assign mul_out[2] = (coff_0[2][4]==1) ? complement_code[2] : {1'b0,dadda_result[2]};
assign mul_out[3] = (coff_1[0][4]==1) ? complement_code[3] : {1'b0,dadda_result[3]};
assign mul_out[4] = (coff_1[1][4]==1) ? complement_code[4] : {1'b0,dadda_result[4]};
assign mul_out[5] = (coff_1[2][4]==1) ? complement_code[5] : {1'b0,dadda_result[5]};
assign mul_out[6] = (coff_2[0][4]==1) ? complement_code[6] : {1'b0,dadda_result[6]};
assign mul_out[7] = (coff_2[1][4]==1) ? complement_code[7] : {1'b0,dadda_result[7]};
assign mul_out[8] = (coff_2[2][4]==1) ? complement_code[8] : {1'b0,dadda_result[8]};

dadda_tree dadda_tree_0(
        .m1(line0_data0),
        .m2({{0,0,0,0},coff_0[0][3:0]}),
        .dadda_result(dadda_result[0])
);
dadda_tree dadda_tree_1(
        .m1(line0_data1),
        .m2({{0,0,0,0},coff_0[1][3:0]}),
        .dadda_result(dadda_result[1])
);
dadda_tree dadda_tree_2(
        .m1(line0_data2),
        .m2({{0,0,0,0},coff_0[2][3:0]}),
        .dadda_result(dadda_result[2])
);
dadda_tree dadda_tree_3(
        .m1(line1_data0),
        .m2({{0,0,0,0},coff_1[0][3:0]}),
        .dadda_result(dadda_result[3])
);
dadda_tree dadda_tree_4(
        .m1(line1_data1),
        .m2({{0,0,0,0},coff_1[1][3:0]}),
        .dadda_result(dadda_result[4])
);
dadda_tree dadda_tree_5(
        .m1(line1_data2),
        .m2({{0,0,0,0},coff_1[2][3:0]}),
        .dadda_result(dadda_result[5])
);
dadda_tree dadda_tree_6(
        .m1(line2_data0),
        .m2({{0,0,0,0},coff_2[0][3:0]}),
        .dadda_result(dadda_result[6])
);
dadda_tree dadda_tree_7(
        .m1(line2_data1),
        .m2({{0,0,0,0},coff_2[1][3:0]}),
        .dadda_result(dadda_result[7])
);
dadda_tree dadda_tree_8(
        .m1(line2_data2),
        .m2({{0,0,0,0},coff_2[2][3:0]}),
        .dadda_result(dadda_result[8])
);



wire [aba_adder_WIDTH+sign_bit-1:0] ADD_OUT_firstlayer  [3:0];
wire [aba_adder_WIDTH+sign_bit-1:0] ADD_OUT_secondlayer [1:0];
wire [aba_adder_WIDTH+sign_bit-1:0] ADD_OUT_thirdlayer;

// -------------connet adder (like a pyramid)------------- //
// 0+4   1+5   2+6   3+7   8        firstlayer
//  0  +  2     1  +  3    8        secondlayer
//     0     +     1       8        thirdlayer
//        0  +  8(8 in firstlayer)  fourthlayer

genvar i;
generate
    begin:ADDER
        for (i=0; i<4; i=i+1) 
        begin: firstlayer
                aba_adder aba_adder_firstlayer(
                        .cin(1'b0),
                        .a(mul_out[i]),
                        .b(mul_out[i+4]),
                        .s(ADD_OUT_firstlayer[i]),
                        .cout()
                );
        end
        for (i=0; i<2; i=i+1)
        begin: secondlayer
                aba_adder aba_adder_secondlayer(
                        .cin(1'b0),
                        .a(ADD_OUT_firstlayer[i]),
                        .b(ADD_OUT_firstlayer[i+2]),
                        .s(ADD_OUT_secondlayer[i]),
                        .cout()
                );
        end
    end
endgenerate

aba_adder aba_adder_thirdlayer(
        .cin(1'b0),
        .a(ADD_OUT_secondlayer[0]),
        .b(ADD_OUT_secondlayer[1]),
        .s(ADD_OUT_thirdlayer),
        .cout()
);
aba_adder aba_adder_fourthlayer(
        .cin(1'b0),
        .a(ADD_OUT_thirdlayer),
        .b(mul_out[8]),
        .s(data_out_r),
        .cout()
);

wire [aba_adder_WIDTH-1:0] data_out_rb;
assign data_out_rb  =  (data_out_r[aba_adder_WIDTH+sign_bit-1:0]==1) ? 0 :  data_out_r;
assign data_out     =    data_out_rb[DATA_WIDTH-1:0];
endmodule