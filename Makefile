# Makefile for the examples

MAKE=make

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

export TJPATH = kernel/ljf:kernel/lkf:kernel/imbed:utils

.PHONY: all
all: $(OBJS)
	cd utils && $(MAKE)
	cd kernel && $(MAKE)


cc: all clean

%.lpo : %.mod %.sig
	tjcc  $*

%.lp : %.lpo
	tjlink  $*

-include depend

.PHONY: clean
clean:
	rm -f *.lpo *.lp
	cd kernel && $(MAKE) clean
	cd utils && $(MAKE) clean

