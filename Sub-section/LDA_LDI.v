module LDA_LDI(
    input [15:0] datain,
    input LDA_sig,
    output [15:0] dataout
);

assign dataout[15] = datain[15] & LDA_sig;
assign dataout[14] = datain[14] & LDA_sig;
assign dataout[13] = datain[13] & LDA_sig;
assign dataout[12] = datain[12] & LDA_sig;
assign dataout[11:0] = datain[11:0];

endmodule


