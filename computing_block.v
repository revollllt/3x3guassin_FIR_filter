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

reg [3:0]   coff_0  [2:0];
reg [3:0]   coff_1  [2:0];
reg [3:0]   coff_2  [2:0];

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
        coff_0[0] <= 1;
        coff_0[1] <= 2;
        coff_0[2] <= 0;
        coff_1[0] <= 2;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 0;
        coff_2[1] <= 0;
        coff_2[2] <= 0;
        end
4'd2 :  begin           // right start//
        coff_0[0] <= 0;
        coff_0[1] <= 2;
        coff_0[2] <= 1;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 2;
        coff_2[0] <= 0;
        coff_2[1] <= 0;
        coff_2[2] <= 0;
        end
4'd3 :  begin           // the left beginning//
        coff_0[0] <= 1;
        coff_0[1] <= 2;
        coff_0[2] <= 0;
        coff_1[0] <= 2;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 1;
        coff_2[1] <= 2;
        coff_2[2] <= 0;
        end
4'd4 :  begin           // the right boarder//
        coff_0[0] <= 0;
        coff_0[1] <= 2;
        coff_0[2] <= 1;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 2;
        coff_2[0] <= 0;
        coff_2[1] <= 2;
        coff_2[2] <= 1;
        end
4'd5 :  begin           // the leftend//
        coff_0[0] <= 0;
        coff_0[1] <= 0;
        coff_0[2] <= 0;
        coff_1[0] <= 2;
        coff_1[1] <= 4;
        coff_1[2] <= 0;
        coff_2[0] <= 1;
        coff_2[1] <= 2;
        coff_2[2] <= 0;
        end
4'd6 :  begin           // the rigntend//
        coff_0[0] <= 0;
        coff_0[1] <= 0;
        coff_0[2] <= 0;
        coff_1[0] <= 0;
        coff_1[1] <= 4;
        coff_1[2] <= 2;
        coff_2[0] <= 0;
        coff_2[1] <= 2;
        coff_2[2] <= 1;
        end
default: begin           // the total 3*3//
        coff_0[0] <= 1;
        coff_0[1] <= 2;
        coff_0[2] <= 1;
        coff_1[0] <= 2;
        coff_1[1] <= 4;
        coff_1[2] <= 2;
        coff_2[0] <= 1;
        coff_2[1] <= 2;
        coff_2[2] <= 1;
        end
endcase
end 

wire   [11:0] data_out_r;
localparam aba_adder_WIDTH = 12;
wire   [aba_adder_WIDTH-1:0] mul_out [8:0];

// store multiply answer in mul_out 

// assign mul_out[0] = line0_data0*coff_0[0];
// assign mul_out[1] = line0_data1*coff_0[1];
// assign mul_out[2] = line0_data2*coff_0[2];
// assign mul_out[3] = line1_data0*coff_1[0];
// assign mul_out[4] = line1_data1*coff_1[1];
// assign mul_out[5] = line1_data2*coff_1[2];
// assign mul_out[6] = line2_data0*coff_2[0];
// assign mul_out[7] = line2_data1*coff_2[1];
// assign mul_out[8] = line2_data2*coff_2[2];

// dadda_tree
wire [15:0] dadda_result [8:0];

assign mul_out[0] = dadda_result[0][aba_adder_WIDTH-1:0];
assign mul_out[1] = dadda_result[1][aba_adder_WIDTH-1:0];
assign mul_out[2] = dadda_result[2][aba_adder_WIDTH-1:0];
assign mul_out[3] = dadda_result[3][aba_adder_WIDTH-1:0];
assign mul_out[4] = dadda_result[4][aba_adder_WIDTH-1:0];
assign mul_out[5] = dadda_result[5][aba_adder_WIDTH-1:0];
assign mul_out[6] = dadda_result[6][aba_adder_WIDTH-1:0];
assign mul_out[7] = dadda_result[7][aba_adder_WIDTH-1:0];
assign mul_out[8] = dadda_result[8][aba_adder_WIDTH-1:0];

dadda_tree dadda_tree_0(
        .m1(line0_data0),
        .m2({{0,0,0,0},coff_0[0]}),
        .dadda_result(dadda_result[0])
);
dadda_tree dadda_tree_1(
        .m1(line0_data1),
        .m2({{0,0,0,0},coff_0[1]}),
        .dadda_result(dadda_result[1])
);
dadda_tree dadda_tree_2(
        .m1(line0_data2),
        .m2({{0,0,0,0},coff_0[2]}),
        .dadda_result(dadda_result[2])
);
dadda_tree dadda_tree_3(
        .m1(line1_data0),
        .m2({{0,0,0,0},coff_1[0]}),
        .dadda_result(dadda_result[3])
);
dadda_tree dadda_tree_4(
        .m1(line1_data1),
        .m2({{0,0,0,0},coff_1[1]}),
        .dadda_result(dadda_result[4])
);
dadda_tree dadda_tree_5(
        .m1(line1_data2),
        .m2({{0,0,0,0},coff_1[2]}),
        .dadda_result(dadda_result[5])
);
dadda_tree dadda_tree_6(
        .m1(line2_data0),
        .m2({{0,0,0,0},coff_2[0]}),
        .dadda_result(dadda_result[6])
);
dadda_tree dadda_tree_7(
        .m1(line2_data1),
        .m2({{0,0,0,0},coff_2[1]}),
        .dadda_result(dadda_result[7])
);
dadda_tree dadda_tree_8(
        .m1(line2_data2),
        .m2({{0,0,0,0},coff_2[2]}),
        .dadda_result(dadda_result[8])
);



wire [aba_adder_WIDTH-1:0] ADD_OUT_firstlayer  [3:0];
wire [aba_adder_WIDTH-1:0] ADD_OUT_secondlayer [1:0];
wire [aba_adder_WIDTH-1:0] ADD_OUT_thirdlayer;

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

wire [11:0] data_out_rb;
assign data_out_rb  =    data_out_r >> 4;
assign data_out    =    data_out_rb[DATA_WIDTH-1:0];
endmodule