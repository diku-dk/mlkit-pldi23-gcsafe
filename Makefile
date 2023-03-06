.PHONY: all
all:
	make -C tools
	make -C benchmarks

.PHONY: clean
clean:
	rm -rf *~ mlkit-pldi23-gcsafe.tar.gz
	make -C tools clean
	make -C benchmarks clean

mlkit-pldi23-gcsafe.tar.gz: Dockerfile
	sudo docker build . -t mlkit-pldi23-gcsafe
	sudo docker save mlkit-pldi23-gcsafe:latest | gzip > $@
