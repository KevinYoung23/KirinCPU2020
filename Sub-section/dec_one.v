module dec_one(
	input [15:0] n,
	output [15:0] out,
	output control
);


assign out = (n > 0) ? n - 1'b1 : 0;
assign control = (n > 0) ? 0 : 1;

endmodule 