# Makefile for the resolution fpcs

MAKE=make

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

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

