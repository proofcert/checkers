# Makefile for the examples

MAKE=make

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

<<<<<<< HEAD
export TJPATH = kernel/tableaux:kernel/ljf:kernel/lkf:kernel/imbed:utils:fpc/tableaux:fpc/resolution:tests/eprover:tests/resolution:tests/tableaux:utils
=======
export TJPATH = kernel/ljf:kernel/lkf:kernel/imbed:utils:fpc/resolution:fpc/tableaux:tests/eprover:tests/resolution:tests/tableaux:utils
>>>>>>> 38e4b1a191c02719a7cbb3f42176d5e4c0b06a6c

.PHONY: all
all: compile

compile: compile_inner $(OBJS)

compile_inner:
	cd utils && $(MAKE)
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
	cd kernel && $(MAKE) clean
	cd utils && $(MAKE) clean

