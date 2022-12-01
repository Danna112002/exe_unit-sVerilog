module Porownywanie (i_argA, i_argB, o_result);
    parameter BITS = 32;
    input  logic [BITS-1:0] i_argA, i_argB;
    output logic            o_result;
    // Blok opisujacy logike 
    always_comb
    begin

        if (i_argA <= i_argB)
        begin
        o_result = 1;
        end
        else o_result = 0;
        
    end
endmodule