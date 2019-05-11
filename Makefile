CC = gcc
LDFLAGS=-Wl,--no-as-needed -ldl
#CFLAGS=-g -O2 -Wall
CFLAGS=-g -Wall

all: memleak-finder.so malloc-stats.so fdleak-finder.so

memleak-finder.o: memleak-finder.c jhash.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<

memleak-finder.so: memleak-finder.o
	$(CC) -shared -o $@ $(LDFLAGS) $^

malloc-stats.o: malloc-stats.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<

malloc-stats.so: malloc-stats.o
	$(CC) -shared -o $@ $(LDFLAGS) $^

fdleak-finder.o: fdleak-finder.c jhash.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<

fdleak-finder.so: fdleak-finder.o
	$(CC) -shared -o $@ $(LDFLAGS) $^

.PHONY: clean
clean:
	rm -f *.o *.so
