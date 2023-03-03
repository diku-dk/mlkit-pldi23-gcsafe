.PHONY: all
all:
	make -C tools
	make -C benchmarks

.PHONY: clean
clean:
	rm -rf *~
	make -C tools clean
	make -C benchmarks clean
