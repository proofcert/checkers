CERTS= \
	col016 \
	col037 \
	col052 \
	col060 \
	col061 \
	col062 \
	col063 \
	col064 \
	col065

ifeq "$(RUNNER)" "elpi"
P=./prover-elpi.sh
else
P=./prover.sh
endif

all:
	$(foreach M,$(CERTS),\
		$(P) --module-name $(M) --prepare-only $(M) &&) true

run:
	$(foreach M,$(CERTS),\
		$(P) --module-name $(M) --run-only $(M) &&) true
