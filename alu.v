`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2023 06:41:05 PM
// Design Name: 
// Module Name: alu
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


module alu #(parameter W = 4)(
    input [W-1:0] A,
    input [W-1:0] B,
    input [2:0] Opcode,
    output reg [W-1:0] result,
    output [2:0] flag
);

    wire [W-1:0] sum;
    wire overflow;

    // Instantiate the adder_gate_level module
    gate_adder adder_inst (
        .A(A),
        .B(B),
        .sum(sum),
        .overflow(overflow)
    );

    // Decode the opcode and set the result accordingly
    always @(*) begin
        case (Opcode)
            3'b000: result = sum;    // Addition
            3'b001: result = A - B;  // Subtraction
            3'b010: result = A & B;  // Bitwise AND
            3'b011: result = A | B;  // Bitwise OR
            3'b100: result = A ^ B;  // Bitwise XOR
            3'b101: result = ~A;     // Bitwise NOT
            3'b110: result = A << 1; // Left shift
            3'b111: result = A >> 1; // Right shift
            default: result = 4'b0000; // Default case
        endcase
    end

    // Set the flag outputs from the overflow signal
    assign flag = {overflow, 2'b00};

endmodule
