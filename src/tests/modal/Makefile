# Makefile for the eprover certs

MAKE=make

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

export TJPATH = ../../calculi/nested-sequents:../../calculi/modal:../../fpc/modal:.../../fpc/tableaux:../../kernel/lkf:../../utils:../..

.PHONY: all
all: $(OBJS)

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

