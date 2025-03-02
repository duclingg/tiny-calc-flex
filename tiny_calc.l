%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

/*
state 0: expects op1
1: expects op
2: expects op2
3: expects state 2
*/

double op1 = 0.0;
double op2 = 0.0;
char op = '\0';
int state = 0;
bool error = false;

// resets varaibles after calulation or error
void reset() {
    op1 = 0.0;
    op2 = 0.0;
    op = '\0';
    state = 0;
    error = false;
}

// basic operations
void calculate() {
    if (state != 3) {
        printf(" - ERROR in the expression\n");
        error = true;
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
                error = true;
                printf(" - ERROR division by zero\n"); 
                break;
            } else {
                printf("%2f\n", op1 / op2); 
                break;
            }
        case '^': printf("%2f\n", pow(op1, op2)); break;
    }
}
%}


digit [0-9]+|([0-9]*)"."([0-9]+)
add "+"
sub "-"
mul "*"
div "/"
pow "^"

ws [ \t]+
nl \n


%%

{digit} {
    // check if state is op1
    if(state == 0) {
        op1 = atof(yytext);
        state = 1;
        printf("%.2f ", op1);
    } else if(state == 2) { // check if state is op
        op2 = atof(yytext);
        state = 3;
        printf("%.2f", op2);
    } else { // check if state is op2
        printf("%s", yytext);
    }
}

{add} {
    if(state == 1) {
        op = '+';
        state = 2;
        printf("+ ");
    } else {
        printf("%s", yytext);
    }
}

{sub} {
    if(state == 1) {
        op = '-';
        state = 2;
        printf("- ");
    } else {
        printf("%s", yytext);
    }
}

{mul} {
    if(state == 1) {
        op = '*';
        state = 2;
        printf("* ");
    } else {
        printf("%s", yytext);
    }
}

{div} {
    if(state == 1) {
        op = '/';
        state = 2;
        printf("/ ");
    } else {
        printf("%s", yytext);
    }
}

{pow} {
    if(state == 1) {
        op = '^';
        state = 2;
        printf("^ ");
    } else {
        printf("%s", yytext);
    }
}

{ws} { } // ignore whitespace

{nl} {
    if(!error) {
        calculate();
    } else {
        printf("\n");
    }
    reset();
    printf(">> ");
}
%%

int yywrap() { return 1; }

int main(int argv, char *argc[]) {
    printf(">> ");
    yylex();
    return 0;
}