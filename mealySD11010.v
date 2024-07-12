// Date: 12/07/2024
// Name: Utkarsha Dongarjal

// Project Name: Mealy State Machine for Sequence Detection of 11010

`timescale 1ns / 1ps

module mealySD11010(det, clk, rst, in);
  input in, clk, rst;
  output reg det;
  reg [2:0] nx_st, prs_st;
  parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

  always @(posedge clk)
    if (rst) 
      prs_st <= S0;
    else 
      prs_st <= nx_st;

  always @ (in, prs_st)
    case (prs_st)
      S0: if (in) nx_st <= S1; else nx_st <= S0;
      S1: if (in) nx_st <= S2; else nx_st <= S0;
      S2: if (in) nx_st <= S1; else nx_st <= S3;
      S3: if (in) nx_st <= S4; else nx_st <= S0;
      S4: if (in) nx_st <= S1; else nx_st <= S0;
      default: nx_st <= S0; // Added default case
    endcase

  always @ (in, prs_st)
    case (prs_st)
      S0: det <= 0;
      S1: det <= 0;
      S2: det <= 0;
      S3: det <= 0;
      S4: if (in) det <= 0; else det <= 1;
      default: det <= 0; // Added default case
    endcase
endmodule

//testbench
module mealySD11010_tb;
reg in, clk, rst;
wire det;
mealySD11010 v1(det, clk, rst, in);
initial begin
clk = 1'b0;
forever #5 clk = ~clk;
end
initial begin 
rst = 1'b0;
forever #150 rst = ~rst;
end
initial begin
in = 1'b0;
#10
in = 1'b1;
#10
in = 1'b1;
#10
in = 1'b0;
#10
in = 1'b1;
#10
in = 1'b0;
#10
in = 1'b0;
#10
in = 1'b1;
#10
in = 1'b0;
#10
in = 1'b1;
#10
in = 1'b1;
#10
in = 1'b0;
#10
in = 1'b1;
#10
in = 1'b0;
#10
in = 1'b1;
#10
$finish;
end
endmodule
