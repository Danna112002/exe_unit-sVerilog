module exe_unit_w48 (i_argA, i_argB, i_oper, o_result, o_status);
    parameter WIDTH = 32;
    input logic              i_clk;
    input logic  [WIDTH-1:0] i_oper;
    input logic  [WIDTH-1:0] i_argB;
    input logic  [WIDTH-1:0] i_argA;
    output logic [WIDTH-1:0] o_result;
    output logic [4:0]       o_status;
    output logic             o_error_konw;
    output logic             o_error_ust;

     logic [WIDTH-1:0] wynik;
     logic [WIDTH-1:0] w_dod;
     logic [WIDTH-1:0] w_por;
     logic [WIDTH-1:0] w_ust;
     logic [WIDTH-1:0] w_konw;

    Dodawanie           #(.WIDTH(WIDTH))        
    Dodawanie            (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_dod), .o_carry(o_status[0]));    
    Porownywanie        #(.BITS(WIDTH))        
    Porownywanie         (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_por));
    ustawianie          #(.BITS(WIDTH))        
    ustawianie           (.i_argA(i_argA), .i_argB(i_argB), .o_result(w_ust), .o_error(o_error_ust));
    konwersja           #(.WIDTH(WIDTH))  
    konwersja            (.i_argA(i_argA), .o_result(w_konw), .o_error(o_error_konw));
    always_comb
    begin
        case(i_oper)
        2'b00 : wynik=w_dod;
        2'b01 : wynik=w_por; 
        2'b10 : wynik=w_ust; 
        2'b11 : wynik=w_konw; 
        default 
        wynik=0;
        endcase
        
    end
    always_ff @(posedge i_clk) begin
    
    end
endmodule