all: bus bus.o

bus: bus.o
	${CC} ${CFLAGS} bus.o -static -lreserve -o bus

bus.o: bus.c
	${CC} ${CFLAGS} -c bus.c
clean:
	rm -rf bus *.o
