module Dodawanie (i_argA, o_result, o_error);
parameter WIDTH=32;
input  logic [WIDTH-1:0]  i_argA;
output logic [WIDTH-1:0] o_result;
output logic             o_error;
       logic             negative;
always_comb
begin
    negative = 1'b0;
    if (i_argA[WIDTH-1]==1) begin
            negative = 1'b1;
end
   if (negative==0) begin
            o_result = i_argA;
   end
   else begin
            o_result= {1'b1, ~i_argA[WIDTH-2:0]+1'b1};
   end
end
endmodule

