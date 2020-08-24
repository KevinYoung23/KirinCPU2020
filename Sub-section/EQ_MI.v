module EQ_MI(
    input [15:0] data,
    output MI,
    output EQ
);

assign EQ = ~data[15] & ~data[14] & ~data[13] & ~data[12] & ~data[11] & ~data[10] & ~data[9] & ~data[8] & ~data[7] & ~data[6] & ~data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
assign MI = data[15];

endmodule