`include "alu_defines.vh"
module exe_unit_w48 (i_argA, i_argB, i_oper, o_result, o_error, o_status, o_carry);
    parameter WIDTH = 32;
    input logic  [`OPER_BITS:0] i_oper;
    input logic                 i_rsn;
    input logic                 i_clk;
    input logic  [WIDTH-1:0]    i_argB;
    input logic  [WIDTH-1:0]    i_argA;
    output logic [WIDTH-1:0]    o_result;
    output logic                o_error;
    output logic [3:0]          o_status;
    output logic                o_error_konw;
    output logic                o_error_ust;
    output logic                o_carry;

     logic [WIDTH-1:0] wynik;
     logic             error;

    // jawne przypisanie portów wejścia/wyjścia do małych modułów
    Dodawanie           #(.WIDTH(WIDTH))        
    Dodawanie            (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_dod), .o_carry(o_carry));    
    Porownywanie        #(.BITS(WIDTH))        
    Porownywanie         (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_por));
    ustawianie          #(.BITS(WIDTH))        
    ustawianie           (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_ust), .o_error(o_error_ust));
    konwersja           #(.WIDTH(WIDTH))  
    konwersja            (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_konw), .o_error(o_error_konw));

    //blok kombinacyjny, pomocniecze zmienne wynik i error są wykorzystywane do zapisywania danych do rejestru
    always_comb
begin
case(i_oper)
`ALU_ADD  : wynik=o_result;
`ALU_COMP : wynik=o_result; 
`ALU_CONV : wynik=o_result; 
`ALU_SET  : wynik=o_result; 
default :
wynik=0;
endcase

end
    //blok synchroniczny 
    always_ff @(posedge i_clk) 
    begin
        o_result<=wynik;
        

    end

endmodule