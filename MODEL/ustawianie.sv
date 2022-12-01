module ustawianie (i_argA, i_argB, o_result, o_error);
    parameter BITS=32;
    localparam MAXINTEGER = 2**BITS-1;
    input logic  [BITS-1:0] i_argA;
    input logic  [BITS-1:0] i_argB;
          logic  [BITS-1:0] tymczasowy_rejestr;
    output logic [BITS-1:0] o_result;
    output logic o_error;
    integer n;
    always_comb begin
        tymczasowy_rejestr=0;
        o_error=0;
    for (n=0;n<BITS;n=n+1) begin
    if (i_argB==n) begin
        tymczasowy_rejestr[n]=1;
    end
    end
    if (i_argB[BITS-1]==1) begin
        o_error = 1;
    end
    if (i_argB>BITS-1) begin
        o_error = 1;
    end
    o_result=tymczasowy_rejestr|i_argA;
    end

endmodule