# The compiler: gcc for C program, define as g++ for C++
CC = g++

# Compiler flags:
#  -g     - this flag adds debugging information to the executable file
#  -Wall  - this flag is used to turn on most compiler warnings
SCCFLAGS  = -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib-linux64 -Wl,-rpath=$SYSTEMC_HOME/lib-linux64 -lm -lsystemc -lpthread
CFLAGS = -Wall -g

# The build target
TARGET = main

# Library source
FILE = etc.cpp

# Targets needed to bring the executable up to date
all: etc.o main.o
	reset
	$(CC) $(SCCFLAGS) -o $(TARGET) etc.o main.o

main.o:
	$(CC) $(CFLAGS) -o main.o -c main.cpp

etc.o:
	$(CC) $(CFLAGS) -o etc.o -c $(FILE)

run:
	reset
	chmod +x main
	./main

clean:
	rm -rf main *.o
