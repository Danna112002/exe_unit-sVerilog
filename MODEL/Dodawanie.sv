module Dodawanie (i_argA, i_argB, i_carry, o_result, o_carry);
parameter WIDTH=32;
input logic              i_carry;
input logic [WIDTH-1:0]  i_argA, i_argB;
output logic [WIDTH-1:0] o_result;
output logic             o_carry;
always_comb
begin
{o_carry, o_result} = i_argA + i_argB + i_carry;
end
endmodule

