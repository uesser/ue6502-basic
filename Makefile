CA65=ca65
LD65=ld65
INCLUDES=-I ./include

basic.bin: basic.o
	$(LD65) -o basic.bin \
		-C basic.cfg \
		basic.o

basic.o: basic.s
	$(CA65) $(INCLUDES) --cpu 65C02 --feature labels_without_colons basic.s

clean:
	rm -f basic.o min_mon.o basic.bin

