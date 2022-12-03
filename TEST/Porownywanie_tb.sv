//testbench dla modulu porownywania

module Porownywanie_tb;
parameter BITS=32;
// sygnały wewnętrzne
logic [BITS-1:0] s_i_argA;
logic [BITS-1:0] s_i_argB;
logic  s_o_model;
logic  s_o_synthesis;
integer i;

// instancjowanie wejść i wyjść, jawne przypisywanie portów

Porownywanie     #(.BITS(BITS))        
Porownywanie     (.i_argA(s_i_argA), .i_argB(s_i_argB), .o_result(s_o_model));    
Porownywanie_rtl           
Porownywanie_rtl (.i_argA(s_i_argA), .i_argB(s_i_argB), .o_result(s_o_synthesis));    

// Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
initial begin
    s_i_argA=0;
    s_i_argB=0;
    $dumpfile("signals.vcd"); //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji 
    $dumpvars(0,Porownywanie_tb);   //Wskazania ze wszystkie sygnaly z testbench i nizej maja byc rejestrowane podczas symulacji
    
// Pętla for przypisująca losowe wartości argumentom wejścia dla pięciu iteracji, rozpoczęcie symulacji
for(i=0;i<=5;i=i+1)
begin
    #10 s_i_argA=$urandom;
        s_i_argB=$urandom;


end

end
endmodule