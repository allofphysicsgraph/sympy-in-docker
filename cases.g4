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
    |   expr SUBTRACT  expr   
    |   LPAREN expr+ RPAREN
    |   LBRACE expr+ RBRACE
    |   LBRACKET expr+ RBRACKET    
    |   BAR variable BAR
    |   function BAR UNDERSCORE variable POW variable
    |   variable
    |   int 
    |  '& '
    |  inequality
    | conditional inequality 
    | '$' expr '$'
    | '\\[' expr '\\]'
    | variable UNDERSCORE LBRACE expr RBRACE 
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
	'\\text' LBRACE 'if' RBRACE
	| '\\text' LBRACE 'if' expr 'is odd' RBRACE COMMA LATEX_NEWLINE
	| '\\text' LBRACE 'if' expr 'is even' RBRACE COMMA LATEX_NEWLINE
	| '\\text' LBRACE 'if' expr 'is odd' RBRACE COMMA DOT
	| '\\text' LBRACE 'if' expr 'is even' RBRACE COMMA DOT
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
COMMA: ',';
DIV : '/' ;
DOT: '.';
EQUALS : '=' |'&='; 
LATEX_NEWLINE: '\\\\' '\\'*;
LBRACE: '{' ;
LBRACKET: '[' ;
LPAREN: '(' ;
MUL : '*' ; 
RBRACE: '}' ;
RBRACKET: ']' ;
RPAREN: ')' ;
SUBTRACT : '-' ;
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
