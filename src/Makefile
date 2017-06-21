# Makefile for the examples

MAKE=make

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

export TJPATH = kernel/modal:syntax:translations:kernel/tableaux:kernel/lkf:utils:fpc/modal:fpc/tableaux:fpc/resolution:tests/eprover:tests/resolution:tests/modal:tests/tableaux:utils

.PHONY: all
all: compile

compile: compile_inner $(OBJS)

compile_inner:
	cd utils && $(MAKE)
	cd syntax && $(MAKE)
	cd translations && $(MAKE)
	cd kernel && $(MAKE)
	cd fpc && $(MAKE)
	cd tests && $(MAKE)

cc: all clean

%.lpo : %.mod %.sig
	tjcc  $*

%.lp : %.lpo
	tjlink  $*

-include depend
depend: *.mod *.sig
	tjdepend *.mod > depend-stage
	mv depend-stage depend

.PHONY: clean
clean:
	rm -rf _debug
	rm -f *.lpo *.lp depend
	cd tests && $(MAKE) clean
	cd fpc && $(MAKE) clean
	cd syntax && $(MAKE) clean
	cd translations && $(MAKE) clean
	cd kernel && $(MAKE) clean
	cd utils && $(MAKE) clean

