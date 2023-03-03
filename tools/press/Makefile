MLCOMP ?= mlkit

.PHONY: all
all: mlkit-press

mlkit-press: Press.mlb Makefile *.sml
	$(MLCOMP) -output $@ $<

.PHONY: clean
clean:
	rm -rf MLB *~ mlkit-press
