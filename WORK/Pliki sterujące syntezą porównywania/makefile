EXAMPLE			 = Porownywanie
MODEL_FILES		 = ${EXAMPLE}.sv
RTL_FILES		 = ${EXAMPLE}_rtl.sv
TB_FILES		 = Porownywanie_tb.sv

rtl:
	# Uruchomienie syntezy yosys
	yosys -s run.ys | tee synth.log

sim: compile
	# Wykonanie skompilowanego programu symulacji 
	./a.out

compile: clear
	# Komilacja modułów verilog do programu wykonywalnego
		iverilog -g2005-sv *.sv					\
					|& tee ${EXAMPLE}.iveri.log

waves:
	# Uruchomienie przeglądarki przebiegów gtkwave
		gtkwave signals.vcd 

clear:
	# usuwanie wyniku kompliacji Icarus verilog
	if [ -f ${EXAMPLE}.iveri.run] ;    \
		then rm ${EXAMPLE}.iveri.run ; fi 