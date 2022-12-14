//testbench ALU;
`timescale 1s/1ms
`define CLKSTEP  10
`define SIMTIME  800 

module exe_unit_w48_tb;
    parameter BITS=32;
    //sygnały sterujące 
    logic               clk, rst = '1;
    logic [BITS-1:0]    i_argA, i_argB;
    logic [1:0]         i_oper;
    //wyjścia danych
    logic [BITS-1:0]    o_result_model;
    logic [3:0]         o_status_model;
    logic [BITS-1:0]    o_result_gates;
    logic [3:0]         o_status_gates;
    logic               o_carry_model;
    logic               o_carry_synthesis;
    //jawne przypisanie portów
    //model
    exe_unit_w48 #(.WIDTH(BITS))
    exe_unit_w48  (.i_argA(i_argA), .i_argB(i_argB), .i_oper(i_oper), .i_clk(clk), .o_result(o_result_model), .o_status(o_status_model), .o_carry(o_carry_model));
    //bramki
    exe_unit_w48_rtl
    exe_unit_w48_rtl  (.i_argA(i_argA), .i_argB(i_argB), .i_oper(i_oper), .i_clk(clk), .o_result(o_result_gates), .o_status(o_status_gates), .o_carry(o_carry_synthesis));
    //generacja sygnału zegarowego
    always #`CLKSTEP clk<=~clk;
    
    //blok generacji losowych danych - (symulacja całkowicie randomowa zostanie zrealizowana potem. Na chwilę obecną sztywno sa zdefiniowaned kroki czasowe)
    integer seed_data=0;
    /*integer delay_data_i_argA=0;
    integer delay_data_i_argB=0;
    integer delay_data_i_oper=0;*/
    always @(clk)
    begin
        #1
            i_argA = $random;
            i_argB = $random;
            i_oper = $urandom_range(0,3);
        
    /*delay_data_i_argA = ($random(seed_data) % `DATASTEP) + `DATASTEP;
    #(delay_data_i_argA) {i_argA, rst} = $random(seed_data);
    delay_data_i_argB = ($random(seed_data) % `DATASTEP) + `DATASTEP;
    #(delay_data_i_argB) {i_argB, rst} = $random(seed_data);
    delay_data_i_oper= ($random(seed_data) % `DATASTEP) + `DATASTEP;
    #2 {i_oper, rst} = {$random(seed_data), '1};*/
    end
    //dla opadającego zbocza zegara pokazuj staty
    integer liczba_testow=0;
    integer liczba_bledow=0;
    always @(negedge clk)
    begin
        liczba_testow = liczba_testow + 1;
            if ((o_result_model === o_result_gates)&&(o_result_model===o_result_gates))
            $display("OK @(%0d): Dane wyjsciowe modelu i bramek zgodne: %d === %d",
            $time, o_result_gates, o_result_model);
        else
        begin
            $display("!!! BLAD @(%0d): Dane wyjsciowe modelu i bramek niezgodne: %d === %d",
            $time, o_result_gates, o_result_model);
            liczba_bledow = liczba_bledow + 1;
        end
    end
    //blok zadania wartosci początkowych i czasu symulacji 
    initial begin
        clk<=0;
        rst<=0;
        i_argA<='0;
        i_argB<='0;
        i_oper<='0;
        $dumpfile("signals_ALU.vcd");
        $dumpvars(0, exe_unit_w48_tb);
        #`SIMTIME;
        $display("--------------------");
        $display("Liczba testow: %0d, liczba bledow: %0d", liczba_testow, liczba_bledow);
        $display("--------------------");
        $finish;
end

endmodule