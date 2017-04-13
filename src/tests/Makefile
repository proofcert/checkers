# Makes all the tests

MAKE=make

.PHONY: all
all:
	cd resolution && $(MAKE)
# need to change ints to indexes for it to compile #	cd eprover && $(MAKE)
	cd tableaux && $(MAKE)
	cd modal && $(MAKE)

.PHONY: clean
clean:
	cd resolution && $(MAKE) clean
# 	cd eprover && $(MAKE) clean
	cd tableaux && $(MAKE) clean
	cd modal && $(MAKE) clean

