stat: stat.s
	as stat.s -o stat.o
	ld stat.o -o stat
	rm *.o
