main:
	flex tiny_calc.l
	g++ lex.yy.c
	