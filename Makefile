# Makefile for the imbedding
SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)
TJROOT = /home/shaolin/usr/bin
#VPATH = ../common

#export TJPATH = ../common


.PHONY: all
all: $(OBJS)

cc: all clean

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
	rm -f *.lpo *.lp *.dt depend

untrace:
	rm *.dt
