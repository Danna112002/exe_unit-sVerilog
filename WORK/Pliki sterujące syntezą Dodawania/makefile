EXAMPLE			 = Dodawanie
MODEL_FILES		 = ${EXAMPLE}.sv
RTL_FILES		 = ${EXAMPLE}_rtl.sv
TB_FILES		 = testbench_dodawanie.sv

rtl:
	# Uruchomienie syntezy yosys
	yosys -s run.ys | tee synth.log

sim: compile
	# Wykonanie skompilowanego programu symulacji 
	./${EXAMPLE}.iveri.run

compile: clear
	# Komilacja modółów verilog do programu wykonywalnego
		iverilog -g2005-sv									\
			${MODEL_FILES} ${RTL_FILES} ${TB_FILES}			\
				-o %{EXAMPLE}.iveri.run						\
					|& tee ${EXAMPLE}.iveri.log

waves:
	# Uruchomienie przeglądarki przebiegów gtkwave
		gtkwave signals.vcd &

# clear:
# usuwanie wyniku kompliacji Icarus verilog
#	if [ -f ${EXAMPLE}.iveri.run] ;    \
		then rm ${EXAMPLE}.iveri.run ; fi 