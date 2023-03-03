MLCOMP ?= mlkit

.PHONY: all
all: smlloc

smlloc: smlloc.mlb Makefile *.sml
	$(MLCOMP) -output $@ $<

.PHONY: clean
clean:
	rm -rf MLB *~ smlloc
