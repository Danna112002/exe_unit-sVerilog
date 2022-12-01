module exe_unit_w48 (i_argA, i_argB, i_oper, o_result, o_error, o_carry);
    parameter WIDTH = 32;
    input logic [WIDTH-1:0] i_oper;
    input logic [WIDTH-1:0] i_argB;
    input logic [WIDTH-1:0] i_argA;
    output logic [WIDTH-1:0] o_result;
    output logic o_error;
    output logic o_error_konw;
    output logic o_error_ust;
    output logic o_carry;
     logic [WIDTH-1:0] w_dod;
     logic [WIDTH-1:0] w_por;
     logic [WIDTH-1:0] w_ust;
     logic [WIDTH-1:0] w_konw;

    Dodawanie     #(.WIDTH(WIDTH))        
    Dodawanie     (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_dod), .o_carry(o_carry));    
    Porownywanie     #(.BITS(WIDTH))        
    Porownywanie     (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_por));
    ustawianie     #(.BITS(WIDTH))        
    ustawianie     (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_ust), .o_error(o_error_ust));
    konwersja       #(.WIDTH(WIDTH))  
    konwersja       (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_konw), .o_error(o_error_konw));

    always_comb
begin
case(i_oper)
2'd2_: o_error=o_error_ust;
2'd3 : o_error=o_error_konw;
endcase
case(i_oper)
2'd0 : o_result=w_dod;
2'd1_: o_result=w_por;
2'd2_: o_result=w_ust;
2'd3 : o_result=w_know;
default :
o_result=0;
endcase
end
endmodule