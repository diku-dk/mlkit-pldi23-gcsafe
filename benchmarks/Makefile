MLKIT=mlkit
MLKIT_BENCH=../tools/bench/mlkit-bench
MLKIT_PRESS=../tools/press/mlkit-press
SMLLOC=../tools/smlloc/smlloc

BENCHFILES=DLX.sml barnes-hut.mlb fft.sml fib37.sml kbc.sml lexgen.sml life.sml logic.mlb \
 mandelbrot.sml mlyacc.mlb mpuz.sml msort-rf.sml msort.sml nucleic.mlb professor.sml      \
 ratio.sml ray.mlb simple.sml tak.sml tsp.sml vliw.sml zebra.sml zern.sml

.PHONY: all
all:
	$(MAKE) static
	$(MAKE) dynamic

.PHONY: clean
clean:
	rm -rf MLB *~ *.exe.out.* *.exe time.out report.json *.auto.mlb
	rm -rf raybench/MLB raybench/*~ nucleic/MLB nucleic/*~
	rm -rf mlyacc/MLB mlyacc/*~ logic/MLB logic/*~ barnes-hut/MLB barnes-hut/*~
	rm -rf *.spurious *.spurious.log *.spurious.no.log *.spurious.yes.log spurious.report static.txt
	rm -rf *.frag *.pct *.log *.json region.ps region.pdf profile.rp *.pdf frag.txt frag_GG.txt dynamic.txt

report.json:
	$(MLKIT_BENCH) -r 10 -o $@ -mlkit -mlkit:-disable_spurious_type_variables -scratch: -mlkit:-no_gc: -mlton $(BENCHFILES:%=./%)

# ----------------------------------------
# Spurious functions (static information)
# ----------------------------------------

%.spurious.log: %
	$(MLKIT) -stats_spurious -o $*.spurious.exe $< > $@

%.spurious.no.log: %
	(rm -rf MLB */MLB; $(MLKIT) -disable_spurious_type_variables -Pcee -o $*.spurious.dummy.exe $< > $@)

%.spurious.yes.log: %
	(rm -rf MLB */MLB; $(MLKIT) -Pcee -o $*.spurious.dummy.exe $< > $@)

%.spurious: %.spurious.log %.spurious.no.log %.spurious.yes.log
	@/bin/echo -n "$* & " | sed 's/.sml//' | sed 's/.mlb//' > $@
	$(SMLLOC) $* | tr -d '\n' >> $@
	@/bin/echo -n ' & ' >> $@
	@grep 'Spurious functions' $< | sed -n -E -e 's/.*: ([0-9]+) \/ ([0-9]+)/\1/p' | awk '{s+=$$1} END {print s}' | tr -d '\n' >> $@
	@/bin/echo -n ' / ' >> $@
	@grep 'Spurious functions' $< | sed -n -E -e 's/.*: ([0-9]+) \/ ([0-9]+)/\2/p' | awk '{s+=$$1} END {print s}' | tr -d '\n' >> $@
	@/bin/echo -n ' & ' >> $@
	@grep 'Spurious instantiations' $< | sed -n -E -e 's/.*: ([0-9]+) \/ ([0-9]+)/\1/p' | awk '{s+=$$1} END {print s}' | tr -d '\n' >> $@
	@/bin/echo -n ' / ' >> $@
	@grep 'Spurious instantiations' $< | sed -n -E -e 's/.*: ([0-9]+) \/ ([0-9]+)/\2/p' | awk '{s+=$$1} END {print s}' | tr -d '\n' >> $@
	@/bin/echo -n ' & ' >> $@
	@(diff -q $*.spurious.no.log $*.spurious.yes.log; /bin/echo -n $$? | sed 's/1/x/' | sed 's/0//' >> $@)
	@/bin/echo '' >> $@

SPURIOUS_FILES=$(BENCHFILES:%=%.spurious)

static.tmp: $(SPURIOUS_FILES)
	/bin/echo 'Program & LoC & Spur. fcns. & Spur. insts. & Code diff' > $@
	cat $^ >> $@

.PHONY: static
static: static.txt
	cat $<

static.txt: static.tmp
	cat $< | column -t -s'&' > $@

.PHONY: dynamic
dynamic: dynamic.txt
	cat $<

dynamic.txt: report.json
	@$(MLKIT_PRESS) -sn -d real -d rss -d gcn -skip1 \
           -merge_rows cname \
           -c pname \
           -c 'real # rg' \
           -c 'real # rg-' \
           -c 'real # r' \
           -c 'real # mlton' \
           -c 'rss # rg' \
           -c 'rss # rg-' \
           -c 'rss # r' \
           -c 'rss # mlton' \
           -c 'gcn # rg' \
           -c 'gcn # rg-' \
           -N -M \
           $< > $@
