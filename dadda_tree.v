`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/19 21:42:59
// Design Name: 
// Module Name: dadda_tree
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dadda_tree(
input [7:0] m1,
input [7:0] m2,
output [15:0] dadda_result 
);
wire [7:0] adder0;
wire [7:0] adder1;//<<1
wire [7:0] adder2;//<<2
wire [7:0] adder3;//<<..
wire [7:0] adder4;
wire [7:0] adder5;
wire [7:0] adder6;
wire [7:0] adder7;

//logic fun//
//the operands that we need to add//
assign adder0 = (m2[0])? m1: 0;
assign adder1 = (m2[1])? m1: 0;
assign adder2 = (m2[2])? m1: 0;
assign adder3 = (m2[3])? m1: 0;
assign adder4 = (m2[4])? m1: 0;
assign adder5 = (m2[5])? m1: 0;
assign adder6 = (m2[6])? m1: 0;
assign adder7 = (m2[7])? m1: 0;
// the final two operands//
wire [14:0] adder_1end;
wire [14:0] adder_2end;

assign adder_1end[1] = adder0[1];
assign adder_2end[1] = adder1[0];

wire c2_carry;
HA hlinec2(adder0[2],adder1[1],adder_1end[2],c2_carry);
assign adder_2end[2] = adder2[0];

wire c3_carry,c3_cout;
// approximate  i0, i1,i2,i3,cin,s,carry,cout
app_counter_5to3 cnt3(adder0[3],adder1[2],adder2[1],adder3[0],c2_carry,adder_1end[3],c3_carry,c3_cout);
assign adder_2end[3] = 0;

wire c4_carry1,c4_carry2,c4_cout,c4_s_1;
HA hlinec4(adder0[4],adder1[3],c4_s_1,c4_carry1);
app_counter_5to3 cnt4(adder2[2],adder3[1],adder4[0],c4_s_1,c3_cout,adder_1end[4],c4_carry2,c4_cout);
assign adder_2end[4] = c3_carry;

wire c5_carry1,c5_carry2,c5_carry3,c5_cout,c5_s_1;
app_counter_5to3 cnt5_1(adder0[5],adder1[4],adder2[3],adder3[2],c4_carry1,c5_s_1,c5_carry1,c5_carry2);
app_counter_5to3 cnt5_2(adder4[1],adder5[0],c5_s_1 ,  1'b0,c4_cout,  adder_1end[5],c5_carry3,c5_cout);
assign adder_2end[5] = c4_carry2;

wire c6_carry1,c6_carry2,c6_carry3,c6_carry4,c6_cout,c6_s_1,c6_s_2;
HA hlinec6(adder0[6],adder1[5],c6_s_1,c6_carry1);
app_counter_5to3 cnt6_1(adder2[4],adder3[3],adder4[2],adder5[1],c5_carry1,c6_s_2,c6_carry2,c6_carry3);
app_counter_5to3 cnt6_2(adder6[0],c6_s_1,c5_carry2,c5_carry3,c5_cout,adder_1end[6],c6_carry4,c6_cout);
assign adder_2end[6] = c6_s_2;

wire c7_carry1,c7_carry2,c7_carry3,c7_carry4,c7_carry5,c7_cout,c7_s_1,c7_s_2;
counter_5to3 cnt7_1(adder0[7],adder1[6],adder2[5],adder3[4],c6_carry1,c7_s_1,c7_carry1,c7_carry2);
counter_5to3 cnt7_2(adder4[3],adder5[2],adder6[1],adder7[0],c6_carry2,c7_s_2,c7_carry3,c7_carry4);
counter_5to3 cnt7_3(c7_s_1,c7_s_2,c6_carry3,  1'b0,c6_cout,adder_1end[7],c7_carry5,c7_cout);
assign adder_2end[7] = c6_carry4;
// approximate  ************************* 
////////////////////////////////////////
///////////////////////////////////////////
// accurate ****************************
wire c8_carry1,c8_carry2,c8_carry3,c8_carry4,c8_carry5,c8_cout,c8_s_1,c8_s_2;
counter_5to3 cnt8_1(adder1[7],adder2[6],adder3[5],adder4[4],c7_carry1,c8_s_1,c8_carry1,c8_carry2);
counter_5to3 cnt8_2(adder5[3],adder6[2],adder7[1],1'b0,c7_carry2,c8_s_2,c8_carry3,c8_carry4);
counter_5to3 cnt8_3(c8_s_1,c8_s_2,c7_carry3,c7_carry4,c7_cout,adder_1end[8],c8_carry5,c8_cout);
assign adder_2end[8] = c7_carry5;

wire c9_carry1,c9_carry2,c9_carry3,c9_carry4,c9_cout,c9_s_1,c9_s_2;
FA hlinec9(adder2[7],adder3[6],c8_carry2,c9_s_1,c9_carry1);
counter_5to3 cnt9_1(adder4[5],adder5[4],adder6[3],adder7[2],c8_carry4,c9_s_2,c9_carry2,c9_carry3);
counter_5to3 cnt9_2(c8_carry1,c8_carry3,c9_s_1,c9_s_2,c8_cout,adder_1end[9],c9_carry4,c9_cout);
assign adder_2end[9] = c8_carry5;

wire c10_carry1,c10_carry2,c10_carry3,c10_cout,c10_s_1,c10_s_2,c10_s_3;
counter_5to3 cnt10_1(adder3[7],adder4[6],adder5[5],adder6[4],c9_carry3,c10_s_1,c10_carry1,c10_carry2);
counter_5to3 cnt10_2(adder7[3],c9_carry1,c10_s_1 ,c9_carry2,c9_cout,adder_1end[10],c10_carry3,c10_cout);
assign adder_2end[10] = c9_carry4;

wire c11_carry1,c11_carry2,c11_cout,c11_s_1,c11_s_2;
FA hlinec11(adder4[7],adder5[6],c10_carry2,c11_s_1,c11_carry1);
counter_5to3 cnt11_1(adder6[5],adder7[4],c11_s_1,c10_carry1,c10_cout,adder_1end[11],c11_carry2,c11_cout);
assign adder_2end[11] = c10_carry3;

wire c12_carry1,c12_cout;
counter_5to3 cnt12_1(adder5[7],adder6[6],adder7[4],c11_carry1,c11_cout,adder_1end[12],c12_carry1,c12_cout);
assign adder_2end[12] = c11_carry2;

wire c13_carry;
FA flinec13(adder6[7],c12_carry1,adder7[6],adder_1end[13],c13_carry);
assign adder_2end[13] = c12_cout;

assign adder_1end[14] = adder7[7];
assign adder_2end[14] = c13_carry;

wire [14:1]c;
assign dadda_result[0] = adder0[0];
HA a1( adder_1end[1],adder_2end[1],dadda_result[1],c[1]);
//FA a2( adder_1end[2],adder_2end[2],c[1],dadda_result[2],c[2]);
assign dadda_result[15] = c[14];
genvar i;
    generate for(i=2; i<15; i=i+1) begin:inst
        FA u_fa(
              //output
              .s(dadda_result[i]),
              .cout(c[i]),
              //input
              .a(adder_1end[i]),
              .b(adder_2end[i]),
              .cin(c[i-1])
           );
    end
    endgenerate

endmodule
