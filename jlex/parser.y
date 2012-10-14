%{
  // compile with byacc/yacc.linux -Jclass=Parser parser.y  
  
  import java.io.IOException;
%}

%token AND OR NOT COMMA DOT IMPLIES
%token OPEN_BRACKET CLOSE_BRACKET
%token OPEN_BRACE CLOSE_BRACE
%token OPEN_PARENTHESIS CLOSE_PARENTHESIS
%token<ival> NUMBER
%token<obj> IDF
%type<obj>  a_literal
%type<obj>  list_of_literals a_clause
%type<obj>  a_term list_of_terms
%type<obj>  a_clause list_of_clauses

%%

problem_specification : list_of_clauses
;
list_of_clauses       : list_of_clauses a_clause
                      | a_clause
;
a_clause              : list_of_literals DOT
;
list_of_literals      : list_of_literals OR a_literal
                      | a_literal
;
a_literal             : IDF OPEN_PARENTHESIS list_of_terms CLOSE_PARENTHESIS {
  Lexem lexem = (Lexem) $1;
  Symbol symb = tableOfSymbols.add(lexem, Symbol.FUNCTION);
  Term t = new Term(symb, (Term) $3);
  symb.declareArity(t);

  $$ = new Literal(true, t);
}
| NOT IDF OPEN_PARENTHESIS list_of_terms CLOSE_PARENTHESIS {
  Lexem lexem = (Lexem) $2;
  Symbol symb = tableOfSymbols.add(lexem, Symbol.FUNCTION);
  Term t = new Term(symb, (Term) $4);
  symb.declareArity(t);

  $$ = new Literal(false, t);
}
;
list_of_terms         : list_of_terms COMMA a_term
                      | a_term
;

a_term : IDF {
  Symbol symb = null;
  Lexem lexem = (Lexem) $1;
  // assert lexem != null
  String name = lexem.getContent();

  if (Character.isUpperCase(name.charAt(0))) {
    symb = tableOfSymbols.add(lexem, Symbol.VARIABLE);
  } else {
    symb = tableOfSymbols.add(lexem, Symbol.CONSTANT);
  } // end of else

  $$ = new Term(symb);
}
| IDF OPEN_PARENTHESIS list_of_terms CLOSE_PARENTHESIS {
  Lexem lexem = (Lexem) $1;
  Symbol symb = tableOfSymbols.add(lexem, Symbol.FUNCTION);
  Term t = new Term(symb, (Term) $3);
  
  $$ = t;
}
;

%%

private Scanner scanner = null;
private SymbolTable tableOfSymbols = null;

private int yylex () {
  int yyl_return = -1;
  try {
    yyl_return = scanner.yylex();
  }
  catch (IOException e) {
    System.err.println("IO error :"+e);
  }
  return yyl_return;
}


public void yyerror(String s)
{
  System.out.println("Parser error :"+s);
}


public Parser(java.io.Reader r) {
  yydebug=true;

  this.scanner=new Scanner(r,this);
  this.tableOfSymbols = new SymbolTable();
}
