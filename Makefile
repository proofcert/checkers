# Makefile for the examples

MAKE=make

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

export TJPATH = src/kernel/ljf:src/kernel/lkf:src/kernel/imbed:src/utils

.PHONY: all
all: $(OBJS)
	cd src/utils && $(MAKE)
	cd src/kernel && $(MAKE)

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
	rm -f *.lpo *.lp depend
	cd src/kernel && $(MAKE) clean
	cd src/utils && $(MAKE) clean

