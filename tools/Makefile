all:
	make -C abstime
	make -C bench
	make -C mem
	make -C speedup
	make -C press
	make -C smlloc

clean:
	make -C abstime clean
	make -C bench clean
	make -C mem clean
	make -C speedup clean
	make -C press clean
	make -C smlloc clean
	find . -name 'MLB' | xargs rm -rf
	rm -rf *~
