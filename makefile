main:
	flex tiny_calc.l
	g++ lex.yy.c -o tiny_calc
	./tiny_calc README.md