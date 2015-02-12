# Makefile for the imbedding

TJROOT = /usr/local/bin
#VPATH = ../common

#export TJPATH = ../common

.PHONY: all 
all: basic ljf lkf

.PHONY: basic
basic: spy.lp control.lp lists.lp 

.PHONY: ljf
ljf: basic ljf-formulas.lp iforms.lp lkf-polarize.lp ljf-kernel.lp stlc-examples.lp mimic-examples.lp jhc-examples.lp

.PHONY: lkf 
lkf: basic lkf-formulas.lp cforms.lp lkf-polarize.lp lkf-kernel.lp cnf-fpc.lp cnf-examples.lp oracle-fpc.lp oracle-examples.lp 


%.lpo : %.mod %.sig
	$(TJROOT)/tjcc  $*

%.lp : %.lpo
	$(TJROOT)/tjlink  $*

-include depend
depend: *.mod *.sig
		$(TJROOT)/tjdepend *.mod  > depend-stage
		mv depend-stage depend

.PHONY: clean
clean:
	rm -f *.lpo *.lp *.DT depend

.PHONY: tests
tests: cnf-examples.lp oracle-examples.lp stlc-examples.lp jhc-examples.lp mimic-examples.lp 
	tjsim -b -s "test_all." cnf-examples.
	tjsim -b -s "test_all." oracle-examples.
	tjsim -b -s "test_all." stlc-examples.
	tjsim -b -s "test_all." jhc-examples.
	tjsim -b -s "test_all." mimic-examples.
