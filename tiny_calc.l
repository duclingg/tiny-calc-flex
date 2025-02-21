/*
(f)lex program for a basic calculator support five artimetic operations:
1. Addition (+)
2. Subtraction (-)
3. Multiplication (*)
4. Division (/)
5. Exponentiation (^)
*/

%{
    
%}

digit [0-9]+|([0-9]*)"."([0-9]+)
add "+"
sub "-"
mul "*"
div "/"
pow "^"

%%

%%

int yywrap() { return 1; }

int main() {
    yylex();
}