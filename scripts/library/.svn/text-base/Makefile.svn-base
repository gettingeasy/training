OBJS = check.o reserve.o

all: ${OBJS} libreserve.so libreserve.a

check.o: check.c
	${CC} ${CFLAGS} -c check.c

reserve.o: reserve.c
	${CC} ${CFLAGS} -c reserve.c

libreserve.a: check.o reserve.o
	ar rcs $@ ${OBJS}

libreserve.so: check.o reserve.o
	gcc -shared -o $@ ${OBJS}

clean:
	rm -rf *.o *.a
