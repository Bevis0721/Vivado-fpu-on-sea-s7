`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 17:46:32
// Design Name: 
// Module Name: testbench
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


module testbench();
reg clk=0;
reg [31:0]A=32'b0_10000001_10010001111010111000011;
reg [31:0]B=32'b0_10000001_10010001111010111000011;
reg [7:0]operator=2'h3;
wire [31:0]result;
wire m_axis_result_tvalid;

always #5 clk<=~clk;

FPU test(
   .clk(clk),
   .A(A),
   .B(B),
   .result(result),
   .operator(operator)
   );
   
   

endmodule
