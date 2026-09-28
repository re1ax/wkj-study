# Makefile

OBJS	= bison.o lex.o main.o reader.o action.o domain.o problem.o planner.o

CC	= g++
CFLAGS	= -g -Wall -ansi

parser:		$(OBJS)
		$(CC) $(CFLAGS) $(OBJS) -o parser -lfl

lex.o:		lex.c
		$(CC) $(CFLAGS) -c lex.c -o lex.o

lex.c:		lcp.lex 
		flex lcp.lex
		cp lex.yy.c lex.c

bison.o:	bison.c
		$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c:	lcp.y
		bison -d -v lcp.y
		cp lcp.tab.c bison.c
		cmp -s lcp.tab.h tok.h || cp lcp.tab.h tok.h

main.o:		main.cpp
		$(CC) $(CFLAGS) -c main.cpp -o main.o

reader.o: reader.cpp
	$(CC) $(CFLAGS) -c reader.cpp -o reader.o

domain.o: domain.cpp
	$(CC) $(CFLAGS) -c domain.cpp -o domain.o

problem.o: problem.cpp
	$(CC) $(CFLAGS) -c problem.cpp -o problem.o

action.o: domain.cpp
	$(CC) $(CFLAGS) -c action.cpp -o action.o

planner.o: planner.cpp
	$(CC) $(CFLAGS) -c planner.cpp -o planner.o

lex.o yac.o main.o	: heading.h
lex.o main.o		: tok.h

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c tok.h lcp.tab.c lcp.tab.h lcp.output parser

