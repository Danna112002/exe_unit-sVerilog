//Jednostka arytmetyczno-logiczna
`include "Dodawanie.sv"
`include "Porownywanie.sv"
`include "ustawianie.sv"
`include "konwersja.sv"
module exe_unit_w48 (i_argA, i_argB, i_oper, i_clk, i_rst, o_carry, o_result, o_status, o_error_konw, o_error_ust);
    parameter WIDTH = 32;
    input logic              i_clk;
    input logic              i_rst;
    input logic  [1:0]       i_oper;
    input logic  [WIDTH-1:0] i_argB;
    input logic  [WIDTH-1:0] i_argA;
    output logic [WIDTH-1:0] o_result;
    output logic [3:0]       o_status;
    output logic             o_error_konw;
    output logic             o_error_ust;
    output logic             o_carry;
    //pomocnicze zmienne do zapisywania do rejestrów
     logic [WIDTH-1:0] wynik;
     logic [WIDTH-1:0] w_dod;
     logic [WIDTH-1:0] w_por;
     logic [WIDTH-1:0] w_ust;
     logic [WIDTH-1:0] w_konw;
     logic flaga_carry;
     logic flaga_error;
     logic flaga_zero;
     logic flaga_negative;
     logic flaga_even;
    //jawne przypisywanie portów do modułów
    Dodawanie           #(.WIDTH(WIDTH))        
    Dodawanie            (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_dod), .o_carry(o_carry));    
    Porownywanie        #(.BITS(WIDTH))        
    Porownywanie         (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_por));
    ustawianie          #(.BITS(WIDTH))        
    ustawianie           (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_ust), .o_error(o_error_ust));
    konwersja           #(.WIDTH(WIDTH))  
    konwersja            (.i_argA(i_argA), .o_result(w_konw), .o_error(o_error_konw));
    //blok synchroniczny 
    always_comb
    begin
        //wybór operacji na danych wejściowych i_oper;
        case(i_oper)
        2'b00 : wynik=w_dod;
        2'b01 : wynik=w_por; 
        2'b10 : wynik=w_ust; 
        2'b11 : wynik=w_konw; 
        default :
        wynik=0;
        endcase        
        //ustawianie flag
        //ustawianie flagi ERROR;
        if((o_error_konw==1'b1)||(o_error_ust==1'b1))
        flaga_error=1'b1;
        else
        flaga_error=1'b0;
        //ustawiane flagi ZERO;
        if(wynik=='0) 
        flaga_zero=1'b1;
        else
        flaga_zero=1'b0;
        //ustawianie flagi NEGATIVE;
        if(wynik[WIDTH-1]==1)
        flaga_negative=1'b1;
        else
        flaga_negative=1'b0;
        //ustawianie flagi EVEN
        if (^wynik==0)
        flaga_even=1'b1;
        else
        flaga_even=1'b0;

    end
    //blok synchronizowalny 
    always_ff @(posedge i_clk, posedge i_rst) begin
        if(i_rst==1'b1)begin
            o_result<='0;
            o_status<='0;
    end
        else begin
            o_result<=wynik;
            o_status<={flaga_even, flaga_negative, flaga_zero, flaga_error};
    end
    end
endmodule