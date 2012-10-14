import java.util.HashMap;

/**
 */
public final class SymbolTable extends HashMap {

    /**
     */
    public Symbol add(Lexem l, int type) {
	String key = l.getContent();
	Symbol symb = null;
	
	if (super.containsKey(key) &&
	    (symb = (Symbol) get(key)).getType() != type) {

	    throw new IllegalArgumentException();
	} // end of if

	symb = new Symbol(l);

	symb.setType(type);

	super.put(key, symb);

	return symb;
    } // end of add

} // end of class SymbolTable
