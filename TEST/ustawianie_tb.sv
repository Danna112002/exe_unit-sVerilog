//testbench dla modulu ustawiania

module ustawianie_tb;
parameter BITS=32;
// sygnały wewnętrzne
logic [BITS-1:0] s_i_argA;
logic [BITS-1:0] s_i_argB;
logic            s_o_error_model;
logic            s_o_error_synthesis;
logic [BITS-1:0] s_o_model;
logic [BITS-1:0] s_o_synthesis;
integer i;

// instancjowanie wejść i wyjść, jawne przypisywanie portów

ustawianie     #(.BITS(BITS))        
ustawianie     (.i_argA(s_i_argA), .i_argB(s_i_argB), .o_result(s_o_model), .o_error(s_o_error_model));    
ustawianie_rtl           
ustawianie_rtl (.i_argA(s_i_argA), .i_argB(s_i_argB), .o_result(s_o_synthesis), .o_error(s_o_error_synthesis));

// Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
initial begin
    s_i_argA=0;
    s_i_argB=0;
    $dumpfile("signals.vcd"); //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji 
    $dumpvars(0,ustawianie_tb);   //Wskazania ze wszystkie sygnaly z testbench i nizej maja byc rejestrowane podczas symulacji
    
// Pętla for przypisująca losowe wartości argumentom wejścia dla pięciu iteracji, rozpoczęcie symulacji
for(i=0;i<=5;i=i+1)
begin
    #10 s_i_argA=0;
        s_i_argB=$urandom_range(0,31);
end

end
endmodule