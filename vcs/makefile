# Simulation Timescale
TIMESCALE = -timescale=1ns/1ps

# VCS
VCS = vcs -full64 -cc gcc -cpp g++ -LDFLAGS -Wl,-no-as-needed
DEFINE_VCD = +define+DUMP_VCD
DEFINE_VPD = +define+DUMP_VPD 
DEFINE_FSDB = +define+DUMP_FSDB

# DVE
DVE = dve -full64

# Verdi
PLI_TAB = $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/novas.tab
PLI_A = $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/pli.a
FSDB = -fsdb -P $(PLI_TAB) $(PLI_A) $(DEFINE_FSDB)

# UVM
UVM_HOME = $(VCS_HOME)/etc/uvm-1.1
UVM = +incdir+$(UVM_HOME)/src +vcs+lic+wai +acc -CC -DVCS -ntb_opts uvm-1.1

# Top
TOP_MODULE = top_tb

all: run verdi

run:	
	$(VCS) -sverilog -f filelist.f 		\
	$(TIMESCALE) 						\
	$(UVM) 								\
	$(FSDB) 							\
	-top $(TOP_MODULE)					\
	-R -l vcs.log  						\
	-debug_access+r 					\
	-cm line+cond+tgl+fsm+branch+assert \
	+UVM_TESTNAME=my_case1				

verdi:
	verdi +v2k -sverilog -f filelist.f -ssf wave.fsdb

cover:
	urg -dir simv.vdb

clean:
	rm -rf csrc simv.daidir simv com.log *.h
	rm -rf *.key *.fsdb* *.vcd *.vpd DVEfiles 
	rm -rf verdiLog novas*
	rm -rf *.log
	rm -rf urgReport simv.vdb

