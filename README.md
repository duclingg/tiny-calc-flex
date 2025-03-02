# Tiny Calculator Using (f)lex
Justin Hoang  

## f(lex) tool
A Unix program that generates a lexical analyzer (token scanner). Helps generate C programs whose control flow is directed by instances of regular expressions in the input stream and the generated C program transforms as input stream into a sequence of tokens.  
- The C compiler compiles the generated `lex.yy.c` source code, producing an object program `a.out`, which is the lexical analyzer that transforms an input stream into a sequence of tokens.  

## Program
This program uses `(f)lex` to create a basic calculator supporting **five artimetic operations**  
1. **Addition (+)**
2. **Subtraction (-)**
3. **Multiplication (*)**
4. **Division (/)**
5. **Exponentiation (^)**  

The calculator accepts binary artimetic expressions entered by the user (one expression per line).
- Each expression:
    - Contains two operands and an operator in infix notation
    - Uses operations that are integers or double-precision floating-point numbers
- Provides clear error messages for: 
    - Incorrect operand formats
    - Missing or invalid operators
    - Invalid artimetic expressions
    - Use of letters (invalid operands or operators)

### How it works
The calculator parses the user input for digits and letters (regex), specific operators allowed, as well as whitespaces and newlines. 

```
digit [0-9]+|([0-9]*)"."([0-9]+)
add "+"
sub "-"
mul "*"
div "/"
pow "^"

ws [ \t]+
nl \n
```
- `nl` Newline: calls `calulate()` if error free.

Each user input is held in memory by a `double` variable `op1`, `op2`, or `op`. It parses the data from the defined varaibles above to determine which if each character in the input matches the corresponding type. Each input is also tracked by a state: 0, 1, 2, or 3.
- State 0: Expects operand 1
- State 1: Expects an operator
- State 2: Expects operand 2
- State 3: Ready to calulate

The digit rule will check if it is a digit, int or double. If accepted from the regex defintion, it will change the current state based on the input.
- if `op1` (state 0) move to `op`
- if `op2` (state 2) move to state 3
- entering a newline `\n` will calulate if error-free

```
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
```

Each operator `op` has it's own rule from the predefined operator types above. It will change the state based on it the rule it met or not, similar to the `digit` rule.

The `calculate()` function also checks for the correct state (state 3) otherwise it will throw an error. It also checks for divion by zero edge case.
```
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
```

## How to Run
1. Navigate to the project directory `tiny-calc-flex`
2. Run the command `make` in the Terminal
    - The program will compile and the lexical analyzer `a.out` as well as the program itself `./tiny_calc`
3. The program will then take in an input, an artimetic expression
    - It will calculate the given expression if accepted, else it will throw an error
4. To exit the calculator, enter `control + c` (Mac) in the Terminal

## Example Output
![alt text](<Screenshot 2025-03-01 at 23.42.48.png>)