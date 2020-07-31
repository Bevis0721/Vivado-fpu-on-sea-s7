`timescale 1ns / 1ps

module qspi_adder#(
parameter addr_width = 8
)(
input clk,
input rst_n,
//RAM 
output reg [addr_width-1:0] addr,
input [7:0] data_in,
output reg [7:0] data_out,
output reg wen
);
//registers & wire
reg [9:0] count; 
wire [7:0] rcount;//0x00 ~ 0x0f : get the data ; 0x10 ~ 0x1f : output the data to RAM
assign rcount = count[9:2];

//FPU
reg [31:0] A;
reg [31:0] B;
reg [7:0] operator;
wire [31:0] result;


//count: counter of clk,mem and result
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        count <= 0;
    else
        if (rcount < 32)
        begin
            count <= count + 1;
         
        end
        else
            count <= 0;
end
//addr: address to RAM, address change while count[1:0] == 2'b00, data store while count[1:0] == 2'b11
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        addr <= 0;
    else
        if (rcount < 32)
            addr <= rcount;
       /* else if (rcount<32)
            addr<=rcount;
          */  
        else
            addr <= 0;
end
//mem:  plus 5 while get the data from data_in and store the data in 0x00 ~ 0x0f
reg [7:0] mem [0:15];
integer i;
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
    begin
        for (i=0;i<15;i=i+1)
            mem[i] <= 0;
    end
    else
        if ((rcount < 16)&&(count[1:0] == 2'b11))
          begin // mem[rcount] <= data_in + 5;
               mem[rcount]<=data_in;//
               if(rcount==11)
               begin
               A<={mem[0],mem[1],mem[2],mem[3]};
               B<={mem[4],mem[5],mem[6],mem[7]};
               operator<=mem[8];
               end
          end
          else if ((rcount==24)&&(count[1:0] == 2'b11))
          begin mem[11]<=result[31:24];
                 mem[12]<=result[23:16];
                 mem[13]<=result[15:8];
                 mem[14]<=result[7:0];
                 end 
                 
                 
end

//data_out: output the data in mem
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        data_out <= 0;
    else
        if ((rcount < 32)&&(count[1:0] == 2'b11))
            data_out <= mem[rcount-16];
        else
            data_out <= 0;
end
//wen: write enable of RAM
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
    begin
        wen <= 0;
    end
    else
        if ((rcount >= 16)&&(rcount<32))
            wen <= 1;
        else
            wen <= 0;
end
FPU u1(
   .clk(clk),
   .A(A),
   .B(B),
   .result(result),
   .operator(operator)
   );
   

endmodule
