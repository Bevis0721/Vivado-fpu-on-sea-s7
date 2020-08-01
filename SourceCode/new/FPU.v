`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 16:08:10
// Design Name: 
// Module Name: FPU
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


module FPU(clk,A,B,operator,result);
input clk;
input [31:0]A;
input [31:0]B;
input [7:0]operator;
output reg [31:0]result;
reg [3:0]C;
    wire [3:0]m_axis_result_tvalid;
    
    reg [31:0] adder_a_in=0;
	reg [31:0] adder_b_in=0;
	wire [31:0] adder_out;

	reg [31:0] multiplier_a_in=0;
	reg [31:0] multiplier_b_in=0;
	wire [31:0] multiplier_out;

	reg [31:0] divider_a_in=0;
	reg [31:0] divider_b_in=0;
	wire [31:0] divider_out;
	
	reg [31:0] subtracter_a_in=0;
	reg [31:0] subtracter_b_in=0;
	wire [31:0] subtracter_out;
	
always@(posedge clk)
begin
case(operator)
2'h0:
begin    adder_a_in<=A;
          adder_b_in<=B;
         result<=adder_out;
end
2'h1:
begin   subtracter_a_in<=A;
         subtracter_b_in<=B;
         result<=subtracter_out;
end
2'h2:
begin   multiplier_a_in<=A;
         multiplier_b_in<=B;
         result<=multiplier_out;
end
2'h3:
begin   divider_a_in=A;
         divider_b_in=B;
         result<=divider_out;
end
default: begin
         subtracter_a_in<=A;
         subtracter_b_in<=B;
         result<=subtracter_out;
         end
endcase
end

//adder module
adder add(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(1'd1),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(adder_a_in),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1'd1),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(adder_b_in),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(m_axis_result_tvalid[0]),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(adder_out)    // output wire [31 : 0] m_axis_result_tdata
);
//subtrcater module	
subtracter sub(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(1'd1),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(subtracter_a_in),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1'd1),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(subtracter_b_in),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(m_axis_result_tvalid[1]),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(subtracter_out)    // output wire [31 : 0] m_axis_result_tdata
);

multiplier mul(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(1'd1),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(multiplier_a_in),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1'd1),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(multiplier_b_in),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(m_axis_result_tvalid[2]),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(multiplier_out)    // output wire [31 : 0] m_axis_result_tdata
);

divider div(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(1'b1),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(divider_a_in),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1'b1),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(divider_b_in),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(m_axis_result_tvalid[3]),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(divider_out)    // output wire [31 : 0] m_axis_result_tdata
);
endmodule
