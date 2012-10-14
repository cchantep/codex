%%

%class Scanner
%byaccj

%{
  // compile with : JFlex/bin/jflex gram.lex
  private Parser yyparser;
  private LexemTable table;
  
  public Scanner(java.io.Reader r, Parser p) {
    this(r);
    yyparser=p;
    table=new LexemTable();
  }

%}

DIGIT  = [0-9]
NUMBER = {DIGIT}+
LETTER = [A-Za-z]
IDF    = {LETTER}+({LETTER}|{DIGIT}|[_])*
BLANKS = ([ \t\f])*

%%

"," { return Parser.COMMA; } 
"(" { return Parser.OPEN_PARENTHESIS; } 
")" { return Parser.CLOSE_PARENTHESIS; } 
"[" { return Parser.OPEN_BRACKET; } 
"]" { return Parser.CLOSE_BRACKET; } 
"-" { return Parser.NOT; } 
"|" { return Parser.OR; } 
"&" { return Parser.AND; } 
"->" { return Parser.IMPLIES; }
"." { return Parser.DOT; }
"\n" { }
{NUMBER} { 
  yyparser.yylval=new ParserVal(yytext()); 
  return Parser.NUMBER; 
}
{IDF} { 
  	yyparser.yylval=new ParserVal((Object)table.add(yytext()));
  	return Parser.IDF; 
}
{BLANKS} { }
. { }
