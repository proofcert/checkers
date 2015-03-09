# Makefile for the examples

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

export TJPATH = kernel/ljf:kernel/lkf:kernel/imbed

.PHONY: all 
all: $(OBJS)

cc: all clean

%.lpo : %.mod %.sig
	tjcc  $*

%.lp : %.lpo
	tjlink  $*

-include depend

.PHONY: clean
clean:
	rm -f *.lpo *.lp

