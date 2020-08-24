module LCG(
    input CLK,
    input LCG_sig, 
	 input [11:0] number,
    output reg [15:0] sum,
    //output reg [15:0] random,
	 output reg Ready
);

localparam [15:0] x0 = 2633;
localparam [15:0] a = 3;
localparam [15:0] b = 3;


reg [15:0] tmpN;
reg [15:0] tmpS;
reg [15:0] tmp; 
reg [1:0] counter;
reg [8:0] i;

initial 
begin
    tmpN <= x0;
    tmpS <= 16'b0;
    counter = 0; 
end

//multiplication function
/*function [15:0] multiply;
input [15:0] a,b;
reg [15:0] tmp;
integer i;

begin
    tmp = a;
    for(i = 1; i < b; i = i + 1)
    begin
        tmp = tmp + a;
    end
    multiply = tmp;
end
endfunction*/



always@(posedge CLK)
begin
	tmp = (counter == a) ? tmpN : tmp + tmpN; 
	counter = (counter == a) ? 1 : counter + 1;
	if(counter == a)
	begin
		tmpN <=  LCG_sig ? tmp + b : 0;
	   tmpS <= LCG_sig ? tmpS + tmpN : 0;
		i <= (LCG_sig) ? (i==number-1) ? i : i + 1 : 0;
	   Ready <= (i == number-1) ? 1 : 0;
		sum <= tmpS;
		//random <= tmpN;
	end
end

/*always@(posedge CLK)
begin
    integer i;
	 

        tmpN = LCG_sig ? (multiply(tmpN,a)) + b : 0;
        tmpS = LCG_sig ? tmpS + tmpN : 0;

	 i = (LCG_sig) ? (i==number-1) ? i : i + 1 : 0;
	 Ready = (i == number-1) ? 1 : 0;
	 sum = tmpS;
    random = tmpN;
    

end*/

endmodule

