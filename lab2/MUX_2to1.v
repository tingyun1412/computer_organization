/* 112550105 */
`timescale 1ns/1ps

module MUX_2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);

/* Write down your code HERE */

always @(*) begin
    if (select == 1'b0)
        result = src1;
	else
        result = src2;
end

endmodule

