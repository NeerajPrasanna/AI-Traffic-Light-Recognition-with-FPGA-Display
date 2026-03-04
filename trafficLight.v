`timescale 1ns / 1ps
module trafficLight (
    input clk,
    input [3:0] din,
    output reg [0:6] seg1,
    output reg [0:6] seg2,
    output reg [0:6] seg3,
    output reg [0:6] seg4
);
always @(posedge clk) begin
    case (din)
        4'b0001: begin
            seg4 = 7'b0100100;
            seg3 = 7'b1110000;
            seg2 = 7'b0000001;
            seg1 = 7'b0011000;
        end
        4'b0010: begin
            seg4 = 7'b0100100;
            seg3 = 7'b1110001;
            seg2 = 7'b1100001;
            seg1 = 7'b1000011;
        end
        4'b0100: begin
            seg4 = 7'b1111111;
            seg3 = 7'b0000100;
            seg2 = 7'b0000001;
            seg1 = 7'b1111111;
        end
        4'b1000: begin
            seg4 = 7'b0110000;
            seg3 = 7'b1111010;
            seg2 = 7'b1111010;
            seg1 = 7'b1111111;
        end
        default: begin
            seg4 = 7'b0110000;
            seg3 = 7'b1111010;
            seg2 = 7'b1111010;
            seg1 = 7'b1000010;
        end
    endcase
end
endmodule
module trafficLight_tb;
    reg clk;
    reg [3:0] din;
    wire [0:6] seg1;
    wire [0:6] seg2;
    wire [0:6] seg3;
    wire [0:6] seg4;
    trafficLight uut (
        .clk(clk),
        .din(din),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3),
        .seg4(seg4)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    integer i;
    initial begin
        $dumpfile("trafficLight.vcd");
        $dumpvars(0, trafficLight_tb);
        $display("Time\tclk\tdin\tseg1\tseg2\tseg3\tseg4");
        $monitor("%0dns\t%b\t%b\t%b\t%b\t%b\t%b", $time, clk, din, seg1, seg2, seg3, seg4);
        din = 4'b0000;
        #10;
        for (i = 0; i < 1000; i = i + 1) begin
            din = $random % 16;
            #10;
        end
        $display("Simulation complete after 1000 cycles.");
        $stop;
    end
endmodule
