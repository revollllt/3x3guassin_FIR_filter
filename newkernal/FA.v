`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/19 21:52:22
// Design Name: 
// Module Name: FA
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


module FA(
    input a,
    input b,
    input cin,
    output s,
    output cout
    );
    wire s0;
    wire ab;
    wire s0c;
    assign s0 = a ^ b;
    assign s0c = s0&cin;
    assign ab = a&b;
    //output//
    assign s = s0^cin;
    assign cout = ab | s0c;
endmodule
