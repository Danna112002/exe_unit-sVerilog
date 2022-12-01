//testbench dla modulu dodawania

module Dodawanie_tb;
parameter BITS=32;
// sygnały wewnętrzne
logic [BITS-1:0] s_i_argA;
logic [BITS-1:0] s_i_argB;
logic            s_i_carry;
logic            s_o_carry_model;
logic            s_o_carry_synthesis;
logic [BITS-1:0] s_o_model;
logic [BITS-1:0] s_o_synthesis;
integer i;

// instancjowanie wejść i wyjść, jawne przypisywanie portów

Dodawanie     #(.WIDTH(BITS))        
Dodawanie     (.i_argA(s_i_argA), .i_argB(s_i_argB), .i_carry(s_i_carry), .o_result(s_o_model), .o_carry(s_o_carry_model));    
Dodawanie_rtl           
Dodawanie_rtl (.i_argA(s_i_argA), .i_argB(s_i_argB), .i_carry(s_i_carry), .o_result(s_o_synthesis), .o_carry(s_o_carry_synthesis));

// Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
initial begin
    s_i_argA=0;
    s_i_argB=0;
    s_i_carry=0;
    $dumpfile("signals.vcd"); //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji 
    $dumpvars(0,Dodawanie_tb);   //Wskazania ze wszystkie sygnaly z testbench i nizej maja byc rejestrowane podczas symulacji
    
// Pętla for przypisująca losowe wartości argumentom wejścia dla pięciu iteracji, rozpoczęcie symulacji
for(i=0;i<=5;i=i+1)
begin
    #10 s_i_argA=$urandom;
        s_i_argB=$urandom;
        $display("Dodawanie dla oryginalnego modelu: i_argA %d + i_argB %d = s_o_model %d", s_i_argA, s_i_argB, s_o_model);


end

end
endmodule