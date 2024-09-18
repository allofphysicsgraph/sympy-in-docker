grammar cases;

prog:   stat+ ; 

stat:   expr             
    |   equation 
    ;

expr:
       expr POW expr+   
    |	expr MUL  expr   
    |   expr DIV  expr  
    |   expr ADD  expr  
    |   expr SUB  expr   
    |   L_PAREN expr+ R_PAREN
    |   L_BRACE expr+ R_BRACE
    |   L_BRACKET expr+ R_BRACKET    
    |   BAR variable BAR
    |   function BAR UNDERSCORE variable POW variable
    |   variable
    |   int 
    |  '& '
    |  inequality
    | conditional inequality 
    | '$' expr '$'
    | '\\[' expr '\\]'
    | variable UNDERSCORE L_BRACE expr R_BRACE 
    | factorial
;



inequality
	: variable relop int
	;
relop
	: '\\geq'
	| '\\ne'
	| '>'
	| '<' 
	;

conditional:
	'\\text' L_BRACE 'if' R_BRACE
	| '\\text' L_BRACE 'if' expr 'is odd' R_BRACE COMMA LATEX_NEWLINE
	| '\\text' L_BRACE 'if' expr 'is even' R_BRACE COMMA LATEX_NEWLINE
	| '\\text' L_BRACE 'if' expr 'is odd' R_BRACE COMMA DOT
	| '\\text' L_BRACE 'if' expr 'is even' R_BRACE COMMA DOT
	;

equation:
	expr+ EQUALS expr+ LATEX_NEWLINE
	| expr+ EQUALS expr+
        |  cases 
	| expr EQUALS cases
	| '\\begin{equation}' expr+ EQUALS cases '\\end{equation}'
	| '\\begin{equation}' equation '\\end{equation}'
;


cases_prefix:
	'\\begin{cases}'
	;

cases_suffix:
	'\\end{cases}'
	;

cases_body:
	   equation+ 
        |  expr* inequality  
        |  variable expr conditional inequality LATEX_NEWLINE? 
        |  int expr conditional inequality LATEX_NEWLINE?
        |  expr+ conditional (DOT|COMMA)? LATEX_NEWLINE? 
	;

cases:
	cases_prefix cases_body+ cases_suffix;


IGNORE:
	('\\begin{verbatim}'
	| '\\end{verbatim}'
	| 'I don\'t understand this'
	| '~'+ '^'
) -> skip	
;

function:
	'f(x)'
	;


variable:
     int VARIABLE
 	| ('-'|'+') VARIABLE
	| VARIABLE	
;


ADD : '+'  ;
BAR:	'|' ;
CMD_BINOM: '\\binom';
CMD_CDOT: '\\cdot';
CMD_DBINOM: '\\dbinom';
CMD_DIV: '\\div';
CMD_MATHIT: '\\mathit';
CMD_TBINOM: '\\tbinom';
CMD_TIMES: '\\times';
COLON: ':';
COMMA: ',';
DIV: '/';
DOT: '.';
EQUALS : '=' |'&='; 
FUNC_ARCCOS: '\\arccos';
FUNC_ARCCOT: '\\arccot';
FUNC_ARCCSC: '\\arccsc';
FUNC_ARCOSH: '\\arcosh';
FUNC_ARCSEC: '\\arcsec';
FUNC_ARCSIN: '\\arcsin';
FUNC_ARCTAN: '\\arctan';
FUNC_ARSINH: '\\arsinh';
FUNC_ARTANH: '\\artanh';
FUNC_COS: '\\cos';
FUNC_COSH: '\\cosh';
FUNC_COT: '\\cot';
FUNC_CSC: '\\csc';
FUNC_EXP: '\\exp';
FUNC_LG: '\\lg';
FUNC_LIM: '\\lim';
FUNC_LN: '\\ln';
FUNC_LOG: '\\log';
FUNC_PROD: '\\prod';
FUNC_SEC: '\\sec';
FUNC_SINH: '\\sinh';
FUNC_SIN: '\\sin';
FUNC_SQRT: '\\sqrt';
FUNC_SUM: '\\sum';
FUNC_TANH: '\\tanh';
FUNC_TAN: '\\tan';
L_ANGLE: '\\langle';
LATEX_NEWLINE: '\\\\' '\\'*;
L_BAR: '\\left|';
L_BRACE: '{';
L_BRACE_LITERAL: '\\{';
L_BRACKET: '[';
L_CEIL: '\\lceil';
L_FLOOR: '\\lfloor';
L_PAREN: '(';
MUL: '*';
R_ANGLE: '\\rangle';
R_BAR: '\\right|';
R_BRACE: '}';
R_BRACE_LITERAL: '\\}';
R_BRACKET: ']';
R_CEIL: '\\rceil';
R_FLOOR: '\\rfloor';
R_PAREN: ')';
SUB: '-';
UNDERSCORE: '_';
VARIABLE: 'a' | 'b' |  'x' | 'y' | 'z' | 'P' | 'r' |'i'|'j'|'S'|'p'|'l'|'V'|'q'|'n';
BANG: '!';
POW: '^';

factorial:
	variable BANG
	;
int :
	('-'|'+')* INT; 

INT:   '0'|[1-9][0-9]*  ;        // match integers
NEWLINE:'\r'? '\n' -> skip ;      // return newlines to parser (is end-statement signal)

constant:
	'e'
	| 'PI'
	;


WS  :   ([ \t]+|'\\,') -> skip  ; // toss out whitespace
