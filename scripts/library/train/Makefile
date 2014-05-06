all: train train.o

train: train.o
	${CC} ${CFLAGS} train.o -static -lreserve -o train

train.o: train.c
	${CC} ${CFLAGS} -c train.c
clean:
	rm -rf train *.o
