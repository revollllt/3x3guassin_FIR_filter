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

wire c3_carry1,c3_carry2,c3_s_1;
HA hlinec3(adder0[3],adder1[2],c3_s_1,c3_carry1);
FA flinec3(adder2[1],adder3[0],c2_carry,adder_1end[3],c3_carry2);
assign adder_2end[3] = c3_s_1;

wire c4_carry1,c4_carry2,c4_carry3,c4_s_1,c4_s_2;
HA hlinec4(adder0[4],adder1[3],c4_s_1,c4_carry1);
FA flinec4_1(adder2[2],c4_s_1,c3_carry1,c4_s_2,c4_carry2);
FA flinec4_2(adder4[0],adder3[1],c3_carry2,adder_1end[4],c4_carry3);
assign adder_2end[4] = c4_s_2;

wire c5_carry1,c5_carry2,c5_carry3,c5_carry4,c5_s_1,c5_s_2,c5_s_3;
HA hlinec5(adder0[5],adder1[4],c5_s_1,c5_carry1);
FA flinec5_1(adder2[3],adder3[2],adder4[1],c5_s_2,c5_carry2);
FA flinec5_2(adder5[0],c5_s_1,c4_carry1,c5_s_3,c5_carry3);
FA flinec5_3(c5_s_2,c4_carry2,c4_carry3,adder_1end[5],c5_carry4);
assign adder_2end[5] = c5_s_3;

wire c6_carry1,c6_carry2,c6_carry3,c6_carry4,c6_carry5,c6_s_1,c6_s_2,c6_s_3,c6_s_4;
HA hlinec6(adder0[6],adder1[5],c6_s_1,c6_carry1);
FA flinec6_1(adder2[4],adder3[3],adder4[2],c6_s_2,c6_carry2);
FA flinec6_2(adder5[1],c6_s_1,adder6[0],c6_s_3,c6_carry3);
FA flinec6_3(c6_s_2,c5_carry1,c5_carry2,c6_s_4,c6_carry4);
FA flinec6_4(c6_s_3,c5_carry3,c5_carry4,adder_1end[6],c6_carry5);
assign adder_2end[6] = c6_s_4;

wire c7_carry1,c7_carry2,c7_carry3,c7_carry4,c7_carry5,c7_carry6,c7_s_1,c7_s_2,c7_s_3,c7_s_4,c7_s_5;
HA hlinec7(adder0[7],adder1[6],c7_s_1,c7_carry1);
FA flinec7_1(adder2[5],adder3[4],adder4[3],c7_s_2,c7_carry2);
FA flinec7_2(adder5[2],c7_s_1,adder6[1],c7_s_3,c7_carry3);
FA flinec7_3(c7_s_2,c6_carry1,adder7[0],c7_s_4,c7_carry4);
FA flinec7_4(c7_s_3,c6_carry2,c6_carry3,c7_s_5,c7_carry5);
FA flinec7_5(c7_s_4,c6_carry4,c6_carry5,adder_1end[7],c7_carry6);
assign adder_2end[7] = c7_s_5;

wire c8_carry1,c8_carry2,c8_carry3,c8_carry4,c8_carry5,c8_carry6,c8_s_1,c8_s_2,c8_s_3,c8_s_4,c8_s_5;
HA hlinec8(adder1[7],adder2[6],c8_s_1,c8_carry1);
FA flinec8_1(adder3[5],adder4[4],adder5[3],c8_s_2,c8_carry2);
FA flinec8_2(adder7[1],c8_s_1,adder6[2],c8_s_3,c8_carry3);
FA flinec8_3(c8_s_2,c7_carry1,c7_carry2,c8_s_4,c8_carry4);
FA flinec8_4(c8_s_3,c7_carry3,c7_carry4,c8_s_5,c8_carry5);
FA flinec8_5(c8_s_4,c7_carry6,c7_carry5,adder_1end[8],c8_carry6);
assign adder_2end[8] = c8_s_5;

wire c9_carry1,c9_carry2,c9_carry3,c9_carry4,c9_carry5,c9_s_1,c9_s_2,c9_s_3,c9_s_4;
FA flinec9_0(adder2[7],adder3[6],adder7[2],c9_s_1,c9_carry1);
FA flinec9_1(adder4[5],adder5[4],adder6[3],c9_s_2,c9_carry2);
FA flinec9_2(c8_carry1,c9_s_1,c8_carry2,c9_s_3,c9_carry3);
FA flinec9_3(c9_s_2,c8_carry3,c8_carry4,c9_s_4,c9_carry4);
FA flinec9_4(c9_s_3,c8_carry5,c8_carry6,adder_1end[9],c9_carry5);
assign adder_2end[9] = c9_s_4;

wire c10_carry1,c10_carry2,c10_carry3,c10_carry4,c10_s_1,c10_s_2,c10_s_3;
FA flinec10_0(adder3[7],adder4[6],adder5[5],c10_s_1,c10_carry1);
FA flinec10_1(adder6[4],adder7[3],c9_carry1,c10_s_2,c10_carry2);
FA flinec10_2(c9_carry2,c10_s_1,c9_carry3,c10_s_3,c10_carry3);
FA flinec10_3(c10_s_2,c9_carry4,c9_carry5,adder_1end[10],c10_carry4);
assign adder_2end[10] = c10_s_3;

wire c11_carry1,c11_carry2,c11_carry3,c11_s_1,c11_s_2;
FA flinec11_0(adder4[7],adder5[6],adder6[5],c11_s_1,c11_carry1);
FA flinec11_1(c10_carry1,c11_s_1,adder7[4],c11_s_2,c11_carry2);
FA flinec11_2(c10_carry2,c10_carry3,c10_carry4,adder_1end[11],c11_carry3);
assign adder_2end[11] = c11_s_2;

wire c12_carry1,c12_carry2,c12_s_1;
FA flinec12_1(adder5[7],adder6[6],adder7[5],c12_s_1,c12_carry1);
FA flinec12_2(c11_carry1,c11_carry2,c11_carry3,adder_1end[12],c12_carry2);
assign adder_2end[12] = c12_s_1;

wire c13_carry;
FA flinec13(adder6[7],c12_carry1,adder7[6],adder_1end[13],c13_carry);
assign adder_2end[13] = c12_carry2;

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
