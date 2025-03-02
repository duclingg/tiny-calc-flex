%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

/*
state 0: expects op1
1: expects op
2: expects op2
*/

double op1 = 0.0;
double op2 = 0.0;
char op = '\0';
int state = 0;
int error = 0;
char error_msg[100] = "";

void reset() {
    op1 = 0.0;
    op2 = 0.0;
    op = '\0';
    state = 0;
    error = 0;
    error_msg[0] = '\0';
}

void calculate() {
    if (state != 3) {
        printf("Error: in the expression\n");
        return;
    }

    printf(" = ");
    switch(op) {
        case '+': printf("%2f\n", op1 + op2); break;
        case '-': printf("%2f\n", op1 - op2); break;
        case '*': printf("%2f\n", op1 * op2); break;
        case '/':
            // check for division by zero
            if(op2 == 0) {
                printf("Error: division by zero\n");
            } else {
                printf("%2f\n", op1 / op2);
            }
        case '^': printf("%2f\n", pow(op1, op2)); break;
    }
}
%}

letter [a-zA-Z]
digit [0-9]+|([0-9]*)"."([0-9]+)
add "+"
sub "-"
mul "*"
div "/"
pow "^"

id {letter}({letter}|[0-9]|"_")*
ws [ \t]+
nl \n

%%

%%

int yywrap() { return 1; }

int main(int argv, char *argc[]) {
    yylex();
}