# Tiny Calculator Using (f)lex

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

## How to Run
1. Navigate to the project directory `tiny-calc-flex`
2. Run the command `make` in the Terminal
    - The program will compile and the lexical analyzer `a.out` as well as the program itself `./tiny_calc`
3. The program will then take in an input, an artimetic expression
    - It will calculate the given expression if accepted, else it will throw an error
4. To exit the calculator, enter `control + c` (Mac) in the Terminal