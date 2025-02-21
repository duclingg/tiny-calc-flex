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

int main(int argv, char *argc[]) {
    yylex();
}