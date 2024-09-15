grammar latex;

prog:   stat+ ; 

stat:   expr             
    |   equation 
    ;

expr:   expr MUL  expr   
    |   expr DIV  expr  
    |   expr ADD  expr  
    |   expr SUBTRACT  expr   
    |   LPAREN expr RPAREN
    |   LBRACE expr RPAREN
    |   LBRACKET expr RBRACKET    
    |   BAR variable BAR
    |   variable
    |   int 
    |  '& '
    |  inequality
    | conditional inequality 
    | '$' expr '$'
    | variable UNDERSCORE LBRACE expr RBRACE 
;


inequality
	: variable relop int
	;
relop
	: '\\geq'
	| '>'
	| '<' 
	;

conditional:
	'\\text' LBRACE 'if' RBRACE
	| '\\text' LBRACE 'if' expr 'is odd' RBRACE COMMA LATEX_NEWLINE
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

cases:
	'\\begin{cases}' equation+ '\\end{cases}'
        | '\\begin{cases}' expr* inequality '\\end{cases}' 
        | '\\begin{cases}' (variable expr conditional inequality LATEX_NEWLINE?)+ '\\end{cases}'
        | '\\begin{cases}' (int expr conditional inequality LATEX_NEWLINE?)+ '\\end{cases}'
	
;

IGNORE:
	('\\begin{verbatim}'
	| '\\end{verbatim}'
	| 'I don\'t understand this'
	| '~'+ '^'
) -> skip	
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
VARIABLE: 'x' | 'y' | 'z' | 'P' | 'r' |'j';

iint :
	('-'|'+')* INT; 

INT:   '0'|[1-9][0-9]*  ;        // match integers
NEWLINE:'\r'? '\n' -> skip ;      // return newlines to parser (is end-statement signal)
WS  :   [ \t]+ -> skip  ; // toss out whitespace
