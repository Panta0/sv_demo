#export VCS_HOME=/home/tools/vcs/2020.12-SP2-5-T-20220509
#export VERDI_HOME=/home/tools/debussy/verdi3_2020.12-SP2-5-T-20220509
export VCS_HOME=/home/tools/vcs/2023.03-SP2-1
export VERDI_HOME=/home/tools/debussy/verdi3_2023.03-SP2-1
export UVM_HOME=/home/ip/shared/external/uvm/1.2/47890374

all: com_fsdb sim
#---------------------------------------------------------------
filelist:
	find ../de ../dv -name "*.v" -o -name "*.sv" > filelist.f
#---------------------------------------------------------------
com_vpd:
	${VCS_HOME}/bin/vcs -f filelist.f \
		-timescale=1ns/1ps  -lca -kdb \
		-full64 +v2k -sverilog -Mupdate +define+DUMP_VPD \
		-debug_all \
		|tee vcs.log
#---------------------------------------------------------------
com_fsdb:
	${VCS_HOME}/bin/vcs -f filelist.f \
		-timescale=1ns/1ps -lca -kdb  \
		-full64 +v2k -sverilog -Mupdate +define+DUMP_FSDB \
	    +incdir+${UVM_HOME}/src -R  ${UVM_HOME}/src/dpi/uvm_dpi.cc -CC -DVCS \
		-cm line+cond+fsm+tgl+branch -cm_glitch 0+settledvals \
		-debug_acc+all -debug_region+cell+encrypt \
		|tee vcs.log

#-cm_dir simv.cm \
#---------------------------------------------------------------
sim:
	./simv  -cm line+cond+fsm+tgl+branch -cm_glitch 0 -verdi |tee sim.log
#---------------------------------------------------------------
dve:
	dve -vpd vcdplus.vpd -script dve.tcl &
#---------------------------------------------------------------
verdi:
	${VERDI_HOME}/bin/verdi -ssy -ssv -ssz -nologo -simflow -simBin simv -ssf debug.fsdb  &
	
#${VERDI_HOME}/bin/verdi -ssy -ssv -ssz -nologo -simflow -simBin simv -ssf debug.fsdb  &
	
#${VERDI_HOME}/bin/verdi -f filelist.f -ssf tb_top.fsdb &
#---------------------------------------------------------------

verdi_cov:
	${VERDI_HOME}/bin/verdi -cov -covdir simv.vdb &

clean:
	rm -rf csrc DVEfiles novas* *.log simv* *fsdb* ucli.key *.vpd verdiLog