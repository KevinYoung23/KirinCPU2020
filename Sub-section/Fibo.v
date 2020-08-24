module Fibo(
	input CLK,
	input reset, 
	input [11:0] operand,
	input [15:0] number,
	output reg wren,
	output reg ready,
	output reg [11:0] address,
	output reg [15:0] result,
	output reg [11:0] bsf
);

reg[15:0] num1, num2;
reg[11:0] counter;
reg[1:0] stage;

initial
begin 
		num1 = 16'b0;
		num2 = 16'b1;
		counter = 12'b0;
		ready = 0;
		result = 16'b1;
		wren = 1;
		bsf = 12'b0;
		stage = 0;
		address = 0;
end

always@(posedge CLK)
begin 
	if(reset)
	begin
		num1 <= 16'b0;
		num2 <= 16'b1;
		counter <= 12'b0;
		ready <= 0;
		wren <= 0;
		address <= 0;
		stage <= 0;
	end
	else
	begin
		if(operand <= bsf)
		begin 
			if((bsf == 0) & (operand == 0))
			begin 
				wren <= 1;
				address <= 0;
				stage <= 3;
				result <= 1;
				counter <= 0;
				ready <= 1;
			end
			else
			begin 
				wren <= 0;
				address <= operand;
				stage <= 3;
				counter <= operand;
				result <= number;
				ready <= (operand == address) ? 1 : 0;
			end
		end
		else
		begin
			if (bsf < 1)
			begin
				if (counter == operand)
				begin
					wren <= ready ? 0 : 1 ;
					stage <= 3;
					ready <= (operand == address) ? 1 : 0;
					bsf <= counter;
					address <= counter;
					result <= num2;
				end
				else
				begin 
					wren <= 1;
					address <= counter;
					counter <= counter + 1;
					num2 <= num1 + num2;
					num1 <= num2;
					result <= num1 + num2; //
					ready <=  0;
				end	
			end
			else 
			begin
					if (stage == 0)
					begin
						wren <= 0;
						address <= bsf - 1;
						stage <= 1;
					end 
					else if(stage == 1)
					begin 
						wren <= 0;
						//num1 = number;
						address <= bsf;
						stage <= 2;
						counter <= bsf;
					end
					else if(stage == 2)
					begin 
						wren <= 0;
						num1 <= number;
						stage <= 3;
					end
					else
					begin
						if(counter == operand)
						begin
							wren <= ready ? 0 : 1 ;
							address <= operand;
							result <= num2;
							ready <= (operand == address) ? 1 : 0;
							stage <= 3;
							bsf <= counter ;
						end 
						else
						begin
						   wren <= 1;
							//temp = num2;
							result <= (counter == bsf) ? number + num1 : num1 + num2;
							num1 <= (counter == bsf) ? number : num2;
							num2 <= num1 + num2;
							address <= counter + 1;
							counter <= counter + 1;
							ready <= 0;
							
						end
					end
			end	
		end
	end
end

endmodule 