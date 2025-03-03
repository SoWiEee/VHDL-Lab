module full_adder (
    input A, B, Cin,
    output Sum, Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (Cin & A);
endmodule

module four_bit_adder_subtractor (
    input [3:0] A, B,
    input mode,  // 0:add, 1:sub
    output [3:0] Result,
    output Cout
);
    wire [3:0] B_in;
    wire [3:0] Carry;
    
    // mode=1 => B complement (B XOR 1)
    assign B_in = B ^ {4{mode}};

    // 4 FAs
    full_adder FA0 (.A(A[0]), .B(B_in[0]), .Cin(mode), .Sum(Result[0]), .Cout(Carry[0]));
    full_adder FA1 (.A(A[1]), .B(B_in[1]), .Cin(Carry[0]), .Sum(Result[1]), .Cout(Carry[1]));
    full_adder FA2 (.A(A[2]), .B(B_in[2]), .Cin(Carry[1]), .Sum(Result[2]), .Cout(Carry[2]));
    full_adder FA3 (.A(A[3]), .B(B_in[3]), .Cin(Carry[2]), .Sum(Result[3]), .Cout(Cout));

endmodule
