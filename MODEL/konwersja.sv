module konwersja (i_argA, o_result, o_error);
parameter WIDTH=32;
input  logic [WIDTH-1:0]  i_argA;
output logic [WIDTH-1:0]  o_result;
output logic              o_error;
always_comb
begin
    if (i_argA[WIDTH-1]==1) begin
      o_result = {1'b1, ~i_argA[WIDTH-2:0]+1'b1};
      if ((i_argA[WIDTH-1] == 1'b1) && (|i_argA[WIDTH-2:0] == 0) ) begin
         o_error = 1'b1;
         end
      else begin
         o_error = 1'b0;
         end
   end
   else begin
      o_result=i_argA;
      o_error=1'b0;
   end
end
endmodule