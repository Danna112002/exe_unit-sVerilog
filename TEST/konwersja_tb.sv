//testbench dla modulu konwersji
module konwersja_tb;
parameter BITS=32;
// sygnały wewnętrzne
logic [BITS-1:0] s_i_argA;
logic [BITS-1:0] s_o_model;
logic [BITS-1:0] s_o_synthesis;
integer i;

// instancjowanie wejść i wyjść, jawne przypisywanie portów

konwersja     #(.WIDTH(BITS))        
konwersja     (.i_argA(s_i_argA), .o_result(s_o_model));    
konwersja_rtl           
konwersja_rtl (.i_argA(s_i_argA), .o_result(s_o_synthesis));    

// Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
initial begin
    s_i_argA=0;
    $dumpfile("signals.vcd"); //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji 
    $dumpvars(0,konwersja_tb);   //Wskazania ze wszystkie sygnaly z testbench i nizej maja byc rejestrowane podczas symulacji
    
// Pętla for przypisująca losowe wartości argumentom wejścia dla pięciu iteracji, rozpoczęcie symulacji
for(i=0;i<=15;i=i+1)
begin
    #10 s_i_argA=$urandom;
end

end
endmodule