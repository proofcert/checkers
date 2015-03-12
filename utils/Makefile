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
depend: *.mod *.sig
		tjdepend *.mod  > depend-stage
		mv depend-stage depend

run:
	tjsim  $(MODULE)

.PHONY: clean
clean:
	rm -f *.lpo *.lp depend

